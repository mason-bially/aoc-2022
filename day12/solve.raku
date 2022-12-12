use v6;
use lib $*PROGRAM.parent.resolve.dirname;

my @hm = cache open('day12/input').lines
    .map(*.ords.map(* - 'a'.ord)>>.Int.Array)
    .Array;

my $max-x = @hm.first.elems;
my $max-y = @hm.elems;

say "{$max-x}x{$max-y}";

my $s-x; my $s-y;
my $e-x; my $e-y;

for ^$max-y -> $y {
    for ^$max-x -> $x {
        my $v = @hm[$y][$x];
        if $v == ('S'.ord - 'a'.ord) {
            $s-x = $x; $s-y = $y;
            @hm[$y][$x] = 0;
        }
        if $v == ('E'.ord - 'a'.ord) {
            $e-x = $x; $e-y = $y;
            @hm[$y][$x] = 25;
        } 
    }
}

say "S {$s-x},{$s-y}";
say "E {$e-x},{$e-y}";

sub neighbors ($y, $x) {
    my @n;
    my $v = @hm[$y][$x];
    @n.push([$y+1, $x]) if ($y+1 < $max-y) && (@hm[$y+1][$x] - $v) <= 1;
    @n.push([$y-1, $x]) if ($y-1 >= 0) && (@hm[$y-1][$x] - $v) <= 1;
    @n.push([$y, $x+1]) if ($x+1 < $max-x) && (@hm[$y][$x+1] - $v) <= 1;
    @n.push([$y, $x-1]) if ($x-1 >= 0) && (@hm[$y][$x-1] - $v) <= 1;
    return @n;
}

my @front = [($s-y, $s-x),];
my %from = "{$s-y},{$s-x}" => "";
my %dis = "{$s-y},{$s-x}" => 0;
while @front.elems {
    my ($cur-y, $cur-x) = @front.pop();
    if $cur-y == $e-y && $cur-x == $e-x {
        last;
    }

    my $cur-dis = %dis{"{$cur-y},{$cur-x}"};
    for neighbors($cur-y, $cur-x) -> ($n-y, $n-x) {
        my $n-k = "{$n-y},{$n-x}";
        if !(%from{$n-k}:exists) {
            @front.prepend([($n-y, $n-x),]);
            %from{$n-k} = [$n-y, $n-x];
            %dis{$n-k} = $cur-dis + 1;
        }
    }
}

my $part-a = %dis{"{$e-y},{$e-x}"};
my $part-b;

say "A: ", $part-a;
say "B: ", $part-b;

say now - INIT now;
