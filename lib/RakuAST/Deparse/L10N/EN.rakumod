# This file contains the English deparsing logic for the Raku
# Programming Language.

#- start of generated part of localization ------------------------------------
#- Generated on 2023-10-07T19:28:02+02:00 by tools/build/makeL10N.raku
#- PLEASE DON'T CHANGE ANYTHING BELOW THIS LINE

my constant %xlation = "block-default", "default", "block-else", "else", "block-elsif", "elsif", "block-for", "for", "block-given", "given", "block-if", "if", "block-loop", "loop", "block-orwith", "orwith", "block-repeat", "repeat", "block-unless", "unless", "block-until", "until", "block-when", "when", "block-whenever", "whenever", "block-while", "while", "block-with", "with", "block-without", "without", "constraint-where", "where", "core-abs", "abs", "core-all", "all", "core-any", "any", "core-append", "append", "core-ast", "ast", "core-atomic-add-fetch", "atomic-add-fetch", "core-atomic-assign", "atomic-assign", "core-atomic-dec-fetch", "atomic-dec-fetch", "core-atomic-fetch", "atomic-fetch", "core-atomic-fetch-add", "atomic-fetch-add", "core-atomic-fetch-dec", "atomic-fetch-dec", "core-atomic-fetch-inc", "atomic-fetch-inc", "core-atomic-fetch-sub", "atomic-fetch-sub", "core-atomic-inc-fetch", "atomic-inc-fetch", "core-atomic-sub-fetch", "atomic-sub-fetch", "core-await", "await", "core-bag", "bag", "core-bail-out", "bail-out", "core-bless", "bless", "core-callframe", "callframe", "core-callsame", "callsame", "core-callwith", "callwith", "core-can-ok", "can-ok", "core-cas", "cas", "core-categorize", "categorize", "core-ceiling", "ceiling", "core-chars", "chars", "core-chdir", "chdir", "core-chmod", "chmod", "core-chomp", "chomp", "core-chop", "chop", "core-chown", "chown", "core-chr", "chr", "core-chrs", "chrs", "core-classify", "classify", "core-close", "close", "core-cmp-ok", "cmp-ok", "core-comb", "comb", "core-combinations", "combinations", "core-cross", "cross", "core-deepmap", "deepmap", "core-defined", "defined", "core-diag", "diag", "core-die", "die", "core-dies-ok", "dies-ok", "core-dir", "dir", "core-does-ok", "does-ok", "core-done", "done", "core-duckmap", "duckmap", "core-elems", "elems", "core-emit", "emit", "core-end", "end", "core-eval-dies-ok", "eval-dies-ok", "core-eval-lives-ok", "eval-lives-ok", "core-exit", "exit", "core-exp", "exp", "core-expmod", "expmod", "core-fail", "fail", "core-fails-like", "fails-like", "core-fc", "fc", "core-first", "first", "core-flat", "flat", "core-flip", "flip", "core-floor", "floor", "core-flunk", "flunk", "core-full-barrier", "full-barrier", "core-get", "get", "core-getc", "getc", "core-gist", "gist", "core-grep", "grep", "core-hash", "hash", "core-head", "head", "core-indent", "indent", "core-index", "index", "core-indices", "indices", "core-indir", "indir", "core-is", "is", "core-is-approx", "is-approx", "core-is-deeply", "is-deeply", "core-isa-ok", "isa-ok", "core-isnt", "isnt", "core-item", "item", "core-join", "join", "core-key", "key", "core-keys", "keys", "core-kv", "kv", "core-last", "last", "core-lastcall", "lastcall", "core-lc", "lc", "core-like", "like", "core-lines", "lines", "core-link", "link", "core-list", "list", "core-lives-ok", "lives-ok", "core-lsb", "lsb", "core-make", "make", "core-map", "map", "core-max", "max", "core-min", "min", "core-minmax", "minmax", "core-mix", "mix", "core-mkdir", "mkdir", "core-move", "move", "core-msb", "msb", "core-next", "next", "core-nextcallee", "nextcallee", "core-nextsame", "nextsame", "core-nextwith", "nextwith", "core-nok", "nok", "core-none", "none", "core-not", "not", "core-note", "note", "core-ok", "ok", "core-one", "one", "core-open", "open", "core-ord", "ord", "core-ords", "ords", "core-pair", "pair", "core-pairs", "pairs", "core-parse-base", "parse-base", "core-pass", "pass", "core-permutations", "permutations", "core-pick", "pick", "core-plan", "plan", "core-pop", "pop", "core-prepend", "prepend", "core-print", "print", "core-printf", "printf", "core-proceed", "proceed", "core-prompt", "prompt", "core-push", "push", "core-put", "put", "core-rand", "rand", "core-redo", "redo", "core-reduce", "reduce", "core-repeated", "repeated", "core-repl", "repl", "core-return", "return", "core-return-rw", "return-rw", "core-reverse", "reverse", "core-rindex", "rindex", "core-rmdir", "rmdir", "core-roll", "roll", "core-rotate", "rotate", "core-round", "round", "core-roundrobin", "roundrobin", "core-run", "run", "core-samecase", "samecase", "core-samemark", "samemark", "core-samewith", "samewith", "core-say", "say", "core-set", "set", "core-shell", "shell", "core-shift", "shift", "core-sign", "sign", "core-signal", "signal", "core-skip", "skip", "core-skip-rest", "skip-rest", "core-sleep", "sleep", "core-sleep-timer", "sleep-timer", "core-sleep-until", "sleep-until", "core-slip", "slip", "core-slurp", "slurp", "core-snip", "snip", "core-snitch", "snitch", "core-so", "so", "core-sort", "sort", "core-splice", "splice", "core-split", "split", "core-sprintf", "sprintf", "core-spurt", "spurt", "core-sqrt", "sqrt", "core-squish", "squish", "core-srand", "srand", "core-subbuf", "subbuf", "core-subbuf-rw", "subbuf-rw", "core-subtest", "subtest", "core-succeed", "succeed", "core-sum", "sum", "core-symlink", "symlink", "core-tail", "tail", "core-take", "take", "core-take-rw", "take-rw", "core-tc", "tc", "core-tclc", "tclc", "core-throws-like", "throws-like", "core-todo", "todo", "core-trim", "trim", "core-trim-leading", "trim-leading", "core-trim-trailing", "trim-trailing", "core-truncate", "truncate", "core-uc", "uc", "core-unimatch", "unimatch", "core-uniname", "uniname", "core-uninames", "uninames", "core-uniparse", "uniparse", "core-uniprop", "uniprop", "core-uniprops", "uniprops", "core-unique", "unique", "core-unival", "unival", "core-univals", "univals", "core-unlike", "unlike", "core-unlink", "unlink", "core-unshift", "unshift", "core-use-ok", "use-ok", "core-val", "val", "core-value", "value", "core-values", "values", "core-warn", "warn", "core-wordcase", "wordcase", "core-words", "words", "core-zip", "zip", "infix-(cont)", "(cont)", "infix-(elem)", "(elem)", "infix-X", "X", "infix-Z", "Z", "infix-^ff", "^ff", "infix-^ff^", "^ff^", "infix-^fff", "^fff", "infix-^fff^", "^fff^", "infix-after", "after", "infix-and", "and", "infix-andthen", "andthen", "infix-before", "before", "infix-but", "but", "infix-cmp", "cmp", "infix-coll", "coll", "infix-div", "div", "infix-does", "does", "infix-eq", "eq", "infix-ff", "ff", "infix-ff^", "ff^", "infix-fff", "fff", "infix-fff^", "fff^", "infix-gcd", "gcd", "infix-ge", "ge", "infix-gt", "gt", "infix-lcm", "lcm", "infix-le", "le", "infix-leg", "leg", "infix-lt", "lt", "infix-max", "max", "infix-min", "min", "infix-minmax", "minmax", "infix-mod", "mod", "infix-ne", "ne", "infix-notandthen", "notandthen", "infix-o", "o", "infix-or", "or", "infix-orelse", "orelse", "infix-unicmp", "unicmp", "infix-x", "x", "infix-xx", "xx", "meta-R", "R", "meta-X", "X", "meta-Z", "Z", "modifier-for", "for", "modifier-given", "given", "modifier-if", "if", "modifier-unless", "unless", "modifier-until", "until", "modifier-when", "when", "modifier-while", "while", "modifier-with", "with", "modifier-without", "without", "multi-multi", "multi", "multi-only", "only", "multi-proto", "proto", "package-class", "class", "package-grammar", "grammar", "package-knowhow", "knowhow", "package-module", "module", "package-native", "native", "package-package", "package", "package-role", "role", "phaser-BEGIN", "BEGIN", "phaser-CATCH", "CATCH", "phaser-CHECK", "CHECK", "phaser-CLOSE", "CLOSE", "phaser-CONTROL", "CONTROL", "phaser-DOC", "DOC", "phaser-END", "END", "phaser-ENTER", "ENTER", "phaser-FIRST", "FIRST", "phaser-INIT", "INIT", "phaser-KEEP", "KEEP", "phaser-LAST", "LAST", "phaser-LEAVE", "LEAVE", "phaser-NEXT", "NEXT", "phaser-POST", "POST", "phaser-PRE", "PRE", "phaser-QUIT", "QUIT", "phaser-UNDO", "UNDO", "prefix-not", "not", "prefix-so", "so", "routine-method", "method", "routine-regex", "regex", "routine-rule", "rule", "routine-sub", "sub", "routine-submethod", "submethod", "routine-token", "token", "scope-HAS", "HAS", "scope-anon", "anon", "scope-augment", "augment", "scope-constant", "constant", "scope-has", "has", "scope-my", "my", "scope-our", "our", "scope-state", "state", "scope-supersede", "supersede", "scope-unit", "unit", "stmt-prefix-also", "also", "stmt-prefix-do", "do", "stmt-prefix-eager", "eager", "stmt-prefix-gather", "gather", "stmt-prefix-hyper", "hyper", "stmt-prefix-lazy", "lazy", "stmt-prefix-quietly", "quietly", "stmt-prefix-race", "race", "stmt-prefix-react", "react", "stmt-prefix-sink", "sink", "stmt-prefix-start", "start", "stmt-prefix-supply", "supply", "stmt-prefix-try", "try", "term-nano", "nano", "term-now", "now", "term-rand", "rand", "term-self", "self", "term-time", "time", "trait-does", "does", "trait-handles", "handles", "trait-hides", "hides", "trait-is", "is", "trait-of", "of", "trait-returns", "returns", "typer-enum", "enum", "typer-subset", "subset", "use-import", "import", "use-need", "need", "use-no", "no", "use-require", "require", "use-use", "use";
role RakuAST::Deparse::L10N::EN {
    method xsyn (str $prefix, str $key) {
        %xlation{"$prefix-$key"} // $key
    }
}

#- PLEASE DON'T CHANGE ANYTHING ABOVE THIS LINE
#- end of generated part of localization --------------------------------------

# vim: expandtab shiftwidth=4
