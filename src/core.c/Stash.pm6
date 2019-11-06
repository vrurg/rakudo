my class Stash { # declared in BOOTSTRAP
    # class Stash is Hash
    #     has str $!longname;

    multi method AT-KEY(Stash:D: Str:D $key) is raw {
        my \storage := nqp::getattr(self,Map,'$!storage');
        nqp::if(
          nqp::existskey(storage,$key),
          nqp::atkey(storage,$key),
          nqp::p6scalarfromdesc(
            ContainerDescriptor::BindHashPos.new(Mu, self, $key)
          )
        )
    }
    multi method AT-KEY(Stash:D: Str() $key, :$global_fallback!) is raw {
        my \storage := nqp::getattr(self,Map,'$!storage');
        nqp::if(
          nqp::existskey(storage,$key),
          nqp::atkey(storage,$key),
          nqp::if(
            $global_fallback,
            nqp::if(
              nqp::existskey(GLOBAL.WHO,$key),
              nqp::atkey(GLOBAL.WHO,$key),
              Failure.new("Could not find symbol '$key'")
            ),
            nqp::p6scalarfromdesc(
              ContainerDescriptor::BindHashPos.new(Mu, self, $key)
            )
          )
        )
    }

    method package_at_key(Stash:D: str $key) {
        my \storage := nqp::getattr(self,Map,'$!storage');
        nqp::ifnull(
          nqp::atkey(storage,$key),
          nqp::stmts(
            (my $pkg := Metamodel::PackageHOW.new_type(:name($key))),
            $pkg.^compose,
            nqp::bindkey(storage,$key,$pkg)
          )
        )
    }

    multi method gist(Stash:D:) {
        self.Str
    }

    multi method Str(Stash:D:) {
        nqp::isnull_s($!longname) ?? '<anon>' !! $!longname
    }

    method merge-symbols(Stash:D: Hash $globalish) { # NQP gives a Hash, not a Stash
        nqp::gethllsym('perl6','ModuleLoader').merge_globals(self,$globalish)
          if $globalish.defined;
    }

    method TAKE-SNAPSHOT(Stash:D:) is raw {
        my \storage := nqp::getattr(self,Map,'$!storage');
        my \iter := nqp::iterator(storage);
        nqp::bindattr(self, Stash, '@!snapshot', nqp::list());
        while iter {
            nqp::shift(iter);
            my \sym := nqp::iterkey_s(iter);
            my \val := nqp::iterval(iter);
            # Item would be 2/3 elements: symbol name, value, subtable if the value is a package type.
            my \item := nqp::list(sym, val);
            if !nqp::isconcrete(val) && nqp::istype(val.HOW, Metamodel::PackageHOW) {
                nqp::push(item, nqp::decont(val.WHO.TAKE-SNAPSHOT));
            }
            nqp::push(@!snapshot, item);
        }
    }

    method !MERGE-SNAPSHOT(Stash:D: @table, \stash) {
        my \storage := nqp::getattr(self, Map, '$!storage');
        for @table -> @item {
            my \sym := @item[0];
            my \val := @item[1];
            my \subtable := @item.elems > 2 ?? @item[2] !! nqp::null();
            unless nqp::existskey(storage, sym) && nqp::atkey(storage, sym) =:= val {
                nqp::bindkey(storage, sym, val);
            }
            if nqp::isconcrete(subtable) {
                self!MERGE-SNAPSHOT(subtable, val.WHO);
            }
        }
    }

    method RESTORE-SNAPSHOT(Stash:D:) {
        self!MERGE-SNAPSHOT(@!snapshot, self);
        nqp::bindattr(self, Stash, '@!snapshot', nqp::list());
    }
}

# vim: ft=perl6 expandtab sw=4
