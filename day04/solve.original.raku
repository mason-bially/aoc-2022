use v6;

# timing 
#say now - INIT now;

my @lines = cache open('day04/input')
    .lines
    .map(*.split(',').map(*.split('-').map({ $^a.Int..$^b.Int }).first).list);

say "A: ", elems @lines
    .grep(-> ($a, $b) { ($a ~~ $b) || ($b ~~ $a) })
    ;

say "B: ", elems @lines
    .grep(-> ($a, $b) { ($a.max ~~ $b) || ($a.min ~~ $b) || ($b.max ~~ $a) || ($b.min ~~ $a) })
    ;
