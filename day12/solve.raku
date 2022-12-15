use v6;
use lib $*PROGRAM.parent.resolve.dirname;
use util::vec2;

my @hm = cache open('day12/input').lines
    .map(*.ords.map(* - 'a'.ord)>>.Int.Array)
    .Array;

my $size = Vec2.size-from(@hm);

say "size: {$size}";

my $s;
my $e;

for $size.grid-iter {
    my $v := $_.index(@hm);
    if $v == ('S'.ord - 'a'.ord) {
        $s = $_; $v = 0;
    }
    if $v == ('E'.ord - 'a'.ord) {
        $e = $_; $v = 25;
    }
}

say "S: {$s}";
say "E: {$e}";

multi calc-dis(Vec2 $start, &test, &end) {
    my @front = [$start];
    my %dis = $start => 0;
    my $cur;
    while @front.elems {
        $cur = @front.pop();
        last if &end($cur);

        my $v = $cur.index(@hm);
        for $size.grid-neighbors($cur).grep({ &test($_.index(@hm), $v) }) {
            if !(%dis{$_}:exists) {
                @front.prepend($_);
                %dis{$_} = %dis{$cur} + 1;
            }
        }
    }
    return %dis{$cur};
}

say "A: ", calc-dis $s, { $^a - $^b <= 1 }, { $_ == $e };

my $part-b = calc-dis $e, { $^b - $^a <= 1 }, { $_.index(@hm) == 0 };
say "B: ", $part-b;

say now - INIT now;
