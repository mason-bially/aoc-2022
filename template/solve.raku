use v6;

# timing 
#say now - INIT now;

my @lines = cache open('dayXX/input.txt')
    .map()
    ;

say "A: ", sum flat list @lines
    .map()
    ;

say "B: ", sum flat list @lines
    .map()
    ;
