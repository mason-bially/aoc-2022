use v6;

my @sacks = cache open('day03/input.txt')
    .lines
    .map(-> $line { 
        $line.comb.map({
            if ($_.ord <= 'Z'.ord) {
                ($_.ord - 'A'.ord) + 27
            } else {
                ($_.ord - 'a'.ord) + 1
            }
        })
    });

say "A: ", sum @sacks.map(
        -> @sack { 
            my $size = @sack.elems;
            @sack[0..$size/2-1], @sack[$size/2..*-1];
    }).map(
        -> (@a, @b) { 
            (@a X @b).grep(-> ($a, $b) {$a == $b}).map(*.head).unique
    }).list.flat;

say "B: ", sum @sacks.map(
        -> @a, @b, @c {
            (@a X @b X @c).grep(-> ($a, $b, $c) {$a == $b == $c}).map(*.head).unique
    }).list.flat;
