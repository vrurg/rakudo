# Keeps track of various special types or other things that the MOP may be
# configured with.
class Perl6::Metamodel::Configuration {
    my $stash_type := nqp::null();
    my $stash_attr_type := nqp::null();

    method set_stash_type($type, $attr_type) {
        $stash_type := $type;
        $stash_attr_type := $attr_type;
    }
    method stash_type() { $stash_type }
    method stash_attr_type() { $stash_attr_type }

    my $submethod_type := nqp::null();
    method set_submethod_type($type) {
        $submethod_type := $type;
    }
    method submethod_type() { $submethod_type }

    my $multi_sig_comparator;
    method set_multi_sig_comparator($comp) {
        $multi_sig_comparator := $comp;
    }
    method compare_multi_sigs($a, $b) {
        nqp::isconcrete($multi_sig_comparator)
            ?? $multi_sig_comparator($a, $b)
            !! 0
    }

    my $role_to_class_applier_type := nqp::null();
    method set_role_to_class_applier_type($rtca_type) {
        $role_to_class_applier_type := $rtca_type;
    }
    method role_to_class_applier_type() { $role_to_class_applier_type }

    my $role_to_role_applier_type := nqp::null();
    method set_role_to_role_applier_type($rtra_type) {
        $role_to_role_applier_type := $rtra_type;
    }
    method role_to_role_applier_type() { $role_to_role_applier_type }

    my &sym_lookup := nqp::null();
    my $Exception := nqp::null();
    method set_sym_lookup_routine(&slr) {
        &sym_lookup := &slr;
        $Exception := &slr(nqp::hllizefor('Exception', 'Raku'));
    }
    method exception_or_string($exception, $die_message, *@pos, *%named) {
        return $die_message if nqp::isnull(&sym_lookup);
        # When &sym_lookup is registered we do have all core exception classes declared. Therefore we can use
        # use &sym_lookup safely. If it fails to find a symbol then fully legit X::NoSuchSymbol will be thrown.
        my $ex_type := &sym_lookup(nqp::hllizefor($exception, 'Raku'));
        # HLLize all named arguments for exception constructor. Note that if an exception attribute is Bool the the
        # caller of this method is responsible for using nqp::hllboolfor to produce a valid Bool instance.
        my %hll_named;
        for %named {
            %hll_named{nqp::iterkey_s($_)} := nqp::hllizefor(nqp::iterval($_), 'Raku');
        }
        $ex_type.new(|@pos, |%hll_named)
    }
    method throw_or_die(*@p, *%c) {
        my $error := self.exception_or_string(|@p, |%c);
        nqp::istype($error, $Exception) ?? $error.throw !! nqp::die($error)
    }

    # XXX Debug only
    method name_type_check($arg, $param, $why, $result) {
        my $arg-name := try { nqp::how(nqp::what($arg)).name(nqp::what($arg)) } || '*unknown*';
        my $param-name := try { nqp::how(nqp::what($param)).name(nqp::what($param)) } || '*unknown*';
        note("? typechecking (", $why, ") ", (nqp::isconcrete($arg) ?? 'concrete' !! 'undefined'), " param ", $arg-name, " vs. param ", $param-name, " -> ", $result);
    }

    # Register HLL symbol for code which doesn't have direct access to this class. For example, moar/Perl6/Ops.nqp
    # relies on this symbol.
    nqp::bindhllsym('Raku', 'METAMODEL_CONFIGURATION', Perl6::Metamodel::Configuration);
}

# vim: expandtab sw=4
