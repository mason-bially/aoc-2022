use v6;

# lesson learned: containerization matters! `(1..3)` is not `1..3`
# lesson learned: slip works in map `map(|*.split(','))` cause ranges don't flatten nicely
# lesson learned: `a ~~ b` is `a in b`
# lesson learned: `||` is not `or`, the second is much MUCH looser
# lesson learned: @arr[*;*] flattens one layer

my @pairs = cache open('day04/input').lines
    .map(|*.split(',').map(*.split('-').map(*.Int).map({ $^a..$^b }).first))
    ;

say "A: ", sum @pairs
    .map({ $^a ~~ $^b || $^b ~~ $^a })
    ;

say "B: ", sum @pairs
    .map({ $^a.max ~~ $^b || $^a.min ~~ $^b || $^b.max ~~ $^a || $^b.min ~~ $^a })
    ;
