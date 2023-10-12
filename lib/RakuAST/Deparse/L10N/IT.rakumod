# This file contains the Italian deparsing logic for the Raku
# Programming Language.

#- start of generated part of localization ------------------------------------
#- Generated on 2023-10-12T16:17:10+02:00 by tools/build/makeL10N.raku
#- PLEASE DON'T CHANGE ANYTHING BELOW THIS LINE

my constant %xlation = "block-default", "predefinita", "block-else", "altro", "block-elsif", "altro-se", "block-for", "per", "block-given", "dato", "block-if", "se", "block-loop", "ciclo", "block-orwith", "o-con", "block-repeat", "ripeti", "block-unless", "salvo-che", "block-until", "finché", "block-when", "quando", "block-whenever", "ogni-volta-che", "block-while", "mentre", "block-with", "con", "block-without", "senza", "constraint-where", "dove", "core-all", "tutti", "core-any", "ogni", "core-append", "aggiungi", "core-await", "aspetta", "core-bag", "borsa", "core-categorize", "categorizzare", "core-ceiling", "soffitto", "core-classify", "classificare", "core-close", "chide", "core-comb", "pettine", "core-combinations", "combinazioni", "core-deepmap", "mappa-profonda", "core-defined", "definito", "core-die", "muori", "core-done", "fatto", "core-duckmap", "mappa-anatra", "core-emit", "emettere", "core-end", "fine", "core-exit", "uscire", "core-fail", "fallire", "core-first", "primo", "core-flat", "piatto", "core-floor", "pavimento", "core-full-barrier", "barriera-completa", "core-get", "prendi", "core-gist", "essenza", "core-head", "testa", "core-indent", "indenta", "core-index", "indice", "core-indices", "indici", "core-item", "articolo", "core-join", "unirsi", "core-key", "chiave", "core-keys", "chiavi", "core-kv", "cv", "core-last", "ultimo", "core-lastcall", "ultima-chiamata", "core-lines", "linee", "core-list", "elenco", "core-make", "fare", "core-map", "mappa", "core-move", "muove", "core-next", "prossimo", "core-nextcallee", "prossimo-chiamato", "core-nextsame", "prossimo-esteso", "core-nextwith", "prossimo-con", "core-none", "nessuno", "core-not", "non", "core-note", "nota", "core-one", "uno", "core-open", "aperto", "core-pair", "paio", "core-pairs", "pai", "core-permutations", "permutazioni", "core-pick", "prendi", "core-print", "stampa", "core-printf", "f-stampa", "core-proceed", "procedi", "core-prompt", "richiesta", "core-push", "spinge", "core-put", "metti", "core-redo", "rifai", "core-reduce", "riduci", "core-repeated", "ripetuto", "core-return", "restituisci", "core-samecase", "stesso-caso", "core-samemark", "stessa-marca", "core-samewith", "stessa-con", "core-say", "dillo", "core-shift", "sposta", "core-sign", "firma", "core-signal", "segno", "core-skip", "salta", "core-sleep", "dormi", "core-sleep-until", "dormi-fino-a", "core-slip", "scivola", "core-slurp", "bevi", "core-snip", "taglia", "core-snitch", "fail-la-spia", "core-so", "così", "core-sort", "ordina", "core-splice", "unisci", "core-split", "divitevi", "core-spurt", "spruzza", "core-squish", "schiaccia", "core-succeed", "riuscirci", "core-sum", "somma", "core-tail", "coda", "core-take", "prendi", "core-take-rw", "prendi-rw", "core-trim", "taglia", "core-trim-leading", "taglia-in-testa", "core-trim-trailing", "taglia-in-coda", "core-truncate", "troncare", "core-value", "valore", "core-values", "valori", "core-warn", "avviso", "core-wordcase", "caso-della-parola", "core-words", "parole", "infix-after", "dopo", "infix-and", "e", "infix-andthen", "e-poi", "infix-before", "prima-di", "infix-but", "però", "infix-does", "fa", "infix-notandthen", "no-e-poi", "infix-o", "c", "infix-or", "o", "infix-orelse", "oppure", "modifier-for", "per", "modifier-given", "dato", "modifier-if", "se", "modifier-unless", "salvo-che", "modifier-until", "fino-a", "modifier-when", "quando", "modifier-while", "mentre", "modifier-with", "con", "modifier-without", "senza", "multi-only", "soltanto", "package-class", "classe", "package-grammar", "grammatica", "package-knowhow", "so-come", "package-module", "modulo", "package-native", "nativo", "package-package", "pacchetto", "package-role", "ruolo", "phaser-BEGIN", "COMINCIA", "phaser-CATCH", "PRENDI", "phaser-CHECK", "CONTROLLA", "phaser-CLOSE", "CHIUDE", "phaser-CONTROL", "CONTROLLO", "phaser-END", "FINE", "phaser-ENTER", "ENTRA", "phaser-FIRST", "PRIMA", "phaser-KEEP", "TIENI", "phaser-LAST", "ULTIMO", "phaser-LEAVE", "VATTENE", "phaser-NEXT", "PROSSIMO", "phaser-QUIT", "LASCIA", "phaser-UNDO", "ANNULLA", "prefix-not", "non", "prefix-so", "così", "routine-method", "metodo", "routine-rule", "regola", "routine-token", "gettone", "scope-constant", "constante", "scope-has", "ha", "scope-HAS", "HA", "scope-my", "il-mio", "scope-our", "il-nostro", "scope-state", "stato", "scope-supersede", "sostituire", "scope-unit", "unità", "stmt-prefix-also", "anche", "stmt-prefix-do", "fate", "stmt-prefix-eager", "impaziente", "stmt-prefix-gather", "raccogliere", "stmt-prefix-lazy", "pigro", "stmt-prefix-quietly", "tranquillamente", "stmt-prefix-race", "gara", "stmt-prefix-react", "reagisce", "stmt-prefix-sink", "cala", "stmt-prefix-start", "comincio", "stmt-prefix-supply", "fornitura", "stmt-prefix-try", "prova", "term-now", "gia", "term-self", "se-stesso", "term-time", "tempo", "traitmod-does", "fa", "traitmod-handles", "gestisce", "traitmod-hides", "nasconde", "traitmod-is", "è", "traitmod-of", "da", "traitmod-returns", "ritorna", "use-import", "importare", "use-need", "bisognare", "use-no", "non", "use-require", "richiedere", "use-use", "usare";
role RakuAST::Deparse::L10N::IT {
    method xsyn (str $prefix, str $key) {
                %xlation{"$prefix-$key"} // $key
    }
}

#- PLEASE DON'T CHANGE ANYTHING ABOVE THIS LINE
#- end of generated part of localization --------------------------------------

# vim: expandtab shiftwidth=4