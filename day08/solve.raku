use v6;
use lib $*PROGRAM.parent.resolve.dirname;

my @f = cache open('day08/input').lines
    .map(*.comb.map(*.ord - '0'.ord)>>.Int.Array)
    .Array;
my $max_y = @f.elems - 1;
my $max_x = @f>>.elems.max - 1;
say "{$max_x+1}x{$max_y+1}";

sub check-vis (@index, &test) {
    my $count = 1;
    for @index {
        when * < 0      { return Pair.new(0, True) };
        when * > $max_y { return Pair.new(0, True) };
        when !&test($_) { return Pair.new($count, False) };
        default         { $count++ };
    };                    return Pair.new($count - 1, True);
}

my @res = cache (^$max_y X ^$max_x).race.map(-> ($y, $x) {
    my $tree = @f[$y][$x].Int;
    my @checks = [
        (($y-1 ... 0),      { @f[$_][$x] < $tree }),
        (($y+1 ... $max_y), { @f[$_][$x] < $tree }),
        (($x-1 ... 0),      { @f[$y][$_] < $tree }),
        (($x+1 ... $max_x), { @f[$y][$_] < $tree }),
    ].map(-> (@r, $t) {check-vis(@r, $t)}).list;
    Pair.new(([*] @checks>>.key), ([||] @checks>>.value))
});

say "A: ", @res>>.value.sum;
say "B: ", @res>>.key.max;
say now - INIT now;