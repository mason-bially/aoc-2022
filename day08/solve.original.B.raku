use v6;
use lib $*PROGRAM.parent.resolve.dirname;

my @f = cache open('day08/input').lines
    .map(*.comb.map(*.ord - '0'.ord)>>.Int.Array)
    .Array;

my $vis-count = 0;
my $high-senic = 0;
for 0..@f-1 -> $y {
    for 0..@f[$y]-1 -> $x {
        my $tree = @f[$y][$x].Int;
        my $scenic = 1;
        my $counter = 1;
        while $y-$counter > 0        && @f[$y-$counter][$x] < $tree { $counter++ };
        $scenic *= $counter; $counter = 1;
        while $x-$counter > 0        && @f[$y][$x-$counter] < $tree { $counter++ };
        $scenic *= $counter; $counter = 1;
        while $y+$counter < @f-1     && @f[$y+$counter][$x] < $tree { $counter++ };
        $scenic *= $counter; $counter = 1;
        while $x+$counter < @f[$y]-1 && @f[$y][$x+$counter] < $tree { $counter++ };
        $scenic *= $counter;
        $high-senic = $scenic if $scenic > $high-senic;
    }
}

say "B: ", $high-senic;
