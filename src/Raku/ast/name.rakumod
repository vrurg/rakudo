# A name. Names range from simple (a single identifier) up to rather more
# complex (including pseudo-packages, interpolated parts, etc.)
class RakuAST::Name is RakuAST::ImplicitLookups {
    has List $!parts;

    method new(*@parts) {
        my $obj := nqp::create(self);
        nqp::bindattr($obj, RakuAST::Name, '$!parts', @parts);
        $obj
    }

    method from-identifier(Str $identifier) {
        self.new(RakuAST::Name::Part::Simple.new($identifier))
    }

    method from-identifier-parts(*@identifiers) {
        my @parts;
        for @identifiers {
            unless nqp::istype($_, Str) || nqp::isstr($_) {
                nqp::die('Expected identifier parts to be Str, but got ' ~ $_.HOW.name($_));
            }
            @parts.push(RakuAST::Name::Part::Simple.new($_));
        }
        self.new(|@parts)
    }

    method parts() {
        self.IMPL-WRAP-LIST($!parts)
    }

    method is-identifier() {
        nqp::elems($!parts) == 1 && nqp::istype($!parts[0], RakuAST::Name::Part::Simple)
    }

    method is-empty() {
        nqp::elems($!parts) ?? False !! True
    }

    method is-simple() {
        for $!parts {
            return False unless nqp::istype($_, RakuAST::Name::Part::Simple);
        }
        True
    }

    method canonicalize() {
        my $canon-parts := nqp::list_s();
        for $!parts {
            if nqp::istype($_, RakuAST::Name::Part::Simple) {
                nqp::push_s($canon-parts, $_.name);
            }
            else {
                nqp::die('canonicalize NYI for non-simple name parts');
            }
        }
        nqp::join('::', $canon-parts)
    }

    method PRODUCE-IMPLICIT-LOOKUPS() {
        self.IMPL-WRAP-LIST(
            self.is-simple
                ?? []
                !! [
                    RakuAST::Type::Setting.new(RakuAST::Name.from-identifier('&INDIRECT_NAME_LOOKUP')),
                    RakuAST::Type::Setting.new(RakuAST::Name.from-identifier('PseudoStash')),
                ]
        )
    }

    method IMPL-QAST-PACKAGE-LOOKUP(RakuAST::IMPL::QASTContext $context, Mu $start-package) {
        my $result := $start-package;
        my $final := $!parts[nqp::elems($!parts) - 1];
        for $!parts {
            # We do .WHO on the current package, followed by the index into it.
            $result := QAST::Op.new( :op('who'), $result );
            $result := $_.IMPL-QAST-PACKAGE-LOOKUP-PART($context, $result, $_ =:= $final);
        }
        $result
    }
}

# Marker role for a part of a name.
class RakuAST::Name::Part {
}

# A simple name part, wrapping a string name.
class RakuAST::Name::Part::Simple is RakuAST::Name::Part {
    has str $.name;

    method new(Str $name) {
        my $obj := nqp::create(self);
        nqp::bindattr_s($obj, RakuAST::Name::Part::Simple, '$!name', $name);
        $obj
    }

    method IMPL-QAST-PACKAGE-LOOKUP-PART(RakuAST::IMPL::QASTContext $context, Mu $stash-qast, Int $is-final, str :$sigil) {
        QAST::Op.new(
            :op('callmethod'),
            :name($is-final ?? 'AT-KEY' !! 'package_at_key'),
            $stash-qast,
            QAST::SVal.new( :value($is-final && $sigil ?? $sigil ~ $!name !! $!name) )
        )
    }

    method IMPL-QAST-INDIRECT-LOOKUP-PART(RakuAST::IMPL::QASTContext $context, Mu $stash-qast, Int $is-final, str :$sigil) {
        QAST::SVal.new( :value($is-final && $sigil ?? $sigil ~ $!name !! $!name) )
    }
}

class RakuAST::Name::Part::Expression is RakuAST::Name::Part {
    has RakuAST::Expression $.expr;

    method new(RakuAST::Expression $expr) {
        my $obj := nqp::create(self);
        nqp::bindattr($obj, RakuAST::Name::Part::Expression, '$!expr', $expr);
        $obj
    }

    method IMPL-QAST-PACKAGE-LOOKUP-PART(RakuAST::IMPL::QASTContext $context, Mu $stash-qast, Int $is-final, str :$sigil) {
        QAST::Op.new(
            :op('callmethod'),
            :name($is-final ?? 'AT-KEY' !! 'package_at_key'),
            $stash-qast,
            $!expr.IMPL-TO-QAST($context),
        )
    }

    method IMPL-QAST-INDIRECT-LOOKUP-PART(RakuAST::IMPL::QASTContext $context, Mu $stash-qast, Int $is-final, str :$sigil) {
        $!expr.IMPL-TO-QAST($context)
    }
}

# An empty name part, implying .WHO
class RakuAST::Name::Part::Empty is RakuAST::Name::Part {

    method new() {
        nqp::create(self);
    }

    method IMPL-QAST-PACKAGE-LOOKUP-PART(RakuAST::IMPL::QASTContext $context, Mu $stash-qast, Int $is-final, str :$sigil) {
        QAST::Op.new(
            :op('who'),
            $stash-qast,
        )
    }
}
