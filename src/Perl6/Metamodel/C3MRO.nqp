role Perl6::Metamodel::C3MRO {
    # Storage of the MRO.
    has %!mro;
    has @!mro;

    # The MRO minus anything that is hidden.
    has @!mro_unhidden;

    my $use_new := 1;
    my $cdebug := nqp::getenvhash<RAKUDO_CLASS_DEBUG>;

    # Computes C3 MRO.
    method compute_mro_orig($class) {
        my @immediate_parents := $class.HOW.parents($class, :local);

        # Provided we have immediate parents...
        my @result;
        if +@immediate_parents {
            if +@immediate_parents == 1 {
                @result := nqp::clone(@immediate_parents[0].HOW.mro(@immediate_parents[0]));
            } else {
                # Build merge list of linearizations of all our parents, add
                # immediate parents and merge.
                my @merge_list;
                for @immediate_parents {
                    @merge_list.push($_.HOW.mro($_));
                }
                @merge_list.push(@immediate_parents);
                @result := self.c3_merge(@merge_list);
            }
        }

        # Put this class on the start of the list, and we're done.
        @result.unshift($class);
        @!mro := @result;

        # Also compute the unhidden MRO (all the things in the MRO that
        # are not somehow hidden).
        my @unhidden;
        my @hidden;
        for @result -> $c {
            unless nqp::can($c.HOW, 'hidden') && $c.HOW.hidden($c) {
                my $is_hidden := 0;
                for @hidden {
                    if nqp::decont($c) =:= nqp::decont($_) {
                        $is_hidden := 1;
                    }
                }
                nqp::push(@unhidden, $c) unless $is_hidden;
            }
            if nqp::can($c.HOW, 'hides') {
                for $c.HOW.hides($c) {
                    nqp::push(@hidden, $_);
                }
            }
        }
        @!mro_unhidden := @unhidden;

        # Debug purpose
        # if $class.HOW.name($class) eq 'HyperWhatever' {
        #     for @!mro {
        #         nqp::print(" -> " ~ $_.HOW.name($_)) if $cdebug;
        #     }
        #     nqp::say("") if $cdebug;
        # }

        @!mro
    }

    method rmro ($obj, :$with_roles = 1, :$unhidden = 0) {
        unless nqp::existskey(%!mro, 'all') {
            self.compute_mro_new($obj);
        }
        nqp::say("with roles: " ~ ($with_roles ?? "YES" !! "NO") ~ ", unhidden: " ~ ($unhidden ?? "YES" !! "NO")) if $cdebug;
        nqp::atkey(
            nqp::atkey(%!mro, ($unhidden ?? 'unhidden' !! 'all')),
            $with_roles ?? 'all' !! 'no_roles'
        );
    }

    method mro_hash () { nqp::hllize(%!mro) }

    method compute_mro_new($class, :$with_roles = 1) {
        my @immediate_parents := $class.HOW.parents($class, :local);
        my @immediate_roles;
        nqp::say("+ compute_mro of " ~ $class.HOW.name($class) ~ " // " ~ $class.HOW.HOW.name($class.HOW) ~ " which is " ~ ($class.HOW.is_composed($class) ?? "" !! "not ") ~ "composed") if $cdebug;
        if $with_roles && nqp::can($class.HOW, 'roles') {
            nqp::say("asking for roles") if $cdebug;
            for $class.HOW.roles($class, :local, :transitive) {
                nqp::say("got roles") if $cdebug;
                # XXX Could be optimized with just getting all concretizations if it's guaranteed that the two lists are
                # always a match. Very likely, this is how things are.
                my @conc_res := $class.HOW.concretization_lookup($class, $_, :local, :transitive);
                nqp::say("got concretization") if $cdebug;
                nqp::push(@immediate_roles, @conc_res[0] ?? @conc_res[1] !! $_);
            }
        } else {
            @immediate_roles := [];
        }

        nqp::say($class.HOW.name($class) ~ " parents:" ~ +@immediate_parents ~ ", roles:" ~ +@immediate_roles) if $cdebug;

        # Provided we have immediate parents...
        my @all;
        my @no_roles;
        if +@immediate_parents {

            # Get MRO of parents depending on whether they do this role.
            sub get_rmro ($parent) {
                if nqp::can($parent.HOW, 'rmro') {
                    $parent.HOW.rmro($parent, :with_roles(1));
                }
                else {
                    $parent.HOW.mro($parent); # Would handle all non-metamodel parents
                }
            }

            if (+@immediate_parents == 1) && (+@immediate_roles == 0) {
                my $p := @immediate_parents[0];
                nqp::say("Getting single parent " ~ $p.HOW.name($p) ~ " of " ~ $p.HOW.HOW.name($p.HOW)) if $cdebug;
                @all := nqp::clone(get_rmro(@immediate_parents[0]));
            } else {
                # Build merge list of linearizations of all our parents, add
                # immediate parents and merge.
                my @merge_list;
                @merge_list.push(@immediate_roles);
                for @immediate_parents {
                    @merge_list.push(get_rmro($_));
                }
                @merge_list.push(@immediate_parents);
                @all := self.c3_merge(@merge_list);
            }
        }

        # Put this class on the start of the list, and we're done.
        @all.unshift($class);

        nqp::print($class.HOW.name($class) ~ ":") if $cdebug;
        for @all {
            nqp::print(" -> " ~ $_.HOW.name($_)) if $cdebug;
            if $_.HOW.archetypes.inheritable || nqp::istype($_.HOW, Perl6::Metamodel::NativeHOW) { # i.e. classes or natives
                nqp::print("+") if $cdebug;
                nqp::push(@no_roles, $_);
            }
        }
        nqp::say("\nall count: " ~ +@all ~ ", no_roles count: " ~ +@no_roles) if $cdebug;

        # Also compute the unhidden MRO (all the things in the MRO that
        # are not somehow hidden).
        my @unhidden;
        my @unhid_no_roles;
        my @hidden;
        for @all -> $c {
            # nqp::say("Is " ~ $c.HOW.name($c) ~ " of " ~ $c.HOW.HOW.name($c.HOW) ~ " hidden? ") if $cdebug;
            unless nqp::can($c.HOW, 'hidden') && $c.HOW.hidden($c) {
                my $is_hidden := 0;
                for @hidden {
                    if nqp::decont($c) =:= nqp::decont($_) {
                        $is_hidden := 1;
                    }
                }
                # nqp::say(" ! " ~ ($is_hidden ?? "Yes" !! "No")) if $cdebug;
                unless $is_hidden {
                    nqp::push(@unhidden, $c);
                    nqp::push(@unhid_no_roles, $c) if $c.HOW.archetypes.inheritable || nqp::istype($_.HOW, Perl6::Metamodel::NativeHOW);
                }
            }
            if nqp::can($c.HOW, 'hides') {
                for $c.HOW.hides($c) {
                    nqp::push(@hidden, $_);
                }
            }
        }

        %!mro := nqp::hash(
            'all', nqp::hash(
                'all', @all,
                'no_roles', @no_roles,
            ),
            'unhidden', nqp::hash(
                'all', @unhidden,
                'no_roles', @unhid_no_roles,
            ),
        );

        # nqp::say("+ done compute_mro for " ~ $class.HOW.name($class)) if $cdebug;
        if $class.HOW.name($class) eq 'HyperWhatever' {
            for nqp::atkey(nqp::atkey(%!mro, 'all'), 'no_roles') {
                # nqp::print(" -> " ~ $_.HOW.name($_)) if $cdebug;
            }
            # nqp::say("") if $cdebug;
        }

        nqp::atkey(nqp::atkey(%!mro, 'all'), 'no_roles');
    }

    method compute_mro($class, :$with_roles = 1) {
        if $use_new {
            self.compute_mro_new($class, :$with_roles);
        }
        else {
            self.compute_mro_orig($class);
        }
    }

    # C3 merge routine.
    method c3_merge(@merge_list) {
        my @result;
        my $accepted;
        my $something_accepted := 0;
        my $cand_count := 0;

        # Try to find something appropriate to add to the MRO.
        for @merge_list {
            my @cand_list := $_;
            if +@cand_list {
                my $rejected := 0;
                my $cand_class := @cand_list[0];
                $cand_count := $cand_count + 1;
                for @merge_list {
                    # Skip current list.
                    unless $_ =:= @cand_list {
                        # Is current candidate in the tail? If so, reject.
                        my $cur_pos := 1;
                        while $cur_pos <= +$_ {
                            if nqp::decont($_[$cur_pos]) =:= nqp::decont($cand_class) {
                                $rejected := 1;
                            }
                            $cur_pos := $cur_pos + 1;
                        }
                    }

                }
                # If we didn't reject it, this candidate will do.
                unless $rejected {
                    $accepted := $cand_class;
                    $something_accepted := 1;
                    last;
                }
            }
        }

        # If we never found any candidates, return an empty list.
        if $cand_count == 0 {
            return @result;
        }

        # If we didn't find anything to accept, error.
        unless $something_accepted {
            nqp::die("Could not build C3 linearization: ambiguous hierarchy");
        }

        # Otherwise, remove what was accepted from the merge lists.
        my $i := 0;
        while $i < +@merge_list {
            my @new_list;
            for @merge_list[$i] {
                unless nqp::decont($_) =:= nqp::decont($accepted) {
                    @new_list.push($_);
                }
            }
            @merge_list[$i] := @new_list;
            $i := $i + 1;
        }

        # Need to merge what remains of the list, then put what was accepted on
        # the start of the list, and we're done.
        @result := self.c3_merge(@merge_list);
        @result.unshift($accepted);
        return @result;
    }

    # Introspects the Method Resolution Order.
    method mro ($obj) {
        if $use_new {
            self.rmro($obj, :unhidden(0), :with_roles(0));
        }
        else {
            self.mro_orig($obj)
        }
    }

    method mro_orig($obj) {
        my @result := @!mro;
        if +@result {
            @result
        }
        else {
            # Never computed before; do it best we can so far (and it will
            # be finalized at compose time).
            self.compute_mro($obj)
        }
    }

    # Introspects the Method Resolution Order without anything that has
    # been hidden.
    method mro_unhidden($obj) {
        if $use_new {
            self.rmro($obj, :unhidden, :with_roles(0));
        }
        else {
            self.mro_unhidden_orig($obj);
        }
    }

    method mro_unhidden_orig($obj) {
        my @result := @!mro_unhidden;
        if +@result {
            @result
        }
        else {
            # Never computed before; do it best we can so far (and it will
            # be finalized at compose time).
            self.compute_mro($obj);
            @!mro_unhidden
        }
    }
}
