role Systemic {
    has Str $.name;
    has Str $.auth;
    has Version $.version;
    has Blob $.signature;
    has Str $.desc;

    submethod BUILD(
      Str :$!name?,
      Str :$!auth?,
      :$version,
      --> Nil
    ) {
        $!version = Version.new($version) if $version
    }
    multi method gist(Systemic:D:) {
        $.name ~ (" ($!version)" if $.version.gist ne "vunknown")
    }
    method Str  { $.name }
    method version {
        $!version //= Version.new(["unknown"], "unknown");
    }
    method name {
        $!name //= "unknown"
    }
    method auth {
        $!auth //= "unknown"
    }
}

# vim: ft=perl6 expandtab sw=4
