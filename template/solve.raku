use v6;
use lib $*PROGRAM.parent.resolve.dirname;

my @lines = cache open('dayXX/input')
    .map()
    ;

say "A: ", sum flat list @lines
    .map()
    ;

say "B: ", sum flat list @lines
    .map()
    ;

say now - INIT now;
