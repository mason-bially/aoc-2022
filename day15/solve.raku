use v6;
use lib $*PROGRAM.parent.resolve.dirname;
use util::vec2;

my @lines = cache open('day15/input').lines;

class Beacon {
    has Vec2 $.s;
    has Int $.d;
}

my Beacon @beacons = [];

for @lines {
    when /'Sensor at x='(\-?\d+)', y='(\-?\d+)': closest beacon is at x='(\-?\d+)', y='(\-?\d+)/ {
        my $s = v2($0.Int, $1.Int);
        my $b = v2($2.Int, $3.Int);
        my $d = ($s.x - $b.x).abs + ($s.y - $b.y).abs;
        @beacons.push(Beacon.new(s => $s, d => $d));
    }
}

sub search-f($f) {
    my Int @regs;
    for @beacons -> $b {
        my $m2d = ($b.s.y - $f).abs - $b.d;
        if $m2d < 0 {
            my $min-x = $b.s.x + $m2d;
            my $max-x = $b.s.x - $m2d;

            my $replaced = False;
            if @regs {
                my @new-regs = [];
                for @regs -> $min-o, $max-o {
                    if $max-o < $min-x || $min-o > $max-x {
                        @new-regs.append([$min-o, $max-o]);
                    } elsif $min-o <= $min-x && $max-o >= $max-x {
                        @new-regs.append([$min-o, $max-o]);
                        $replaced = True;
                    } elsif $min-o < $min-x && $max-o < $max-x {
                        $min-x min= $min-o;
                    } elsif $min-o > $min-x && $max-o > $max-x {
                        @new-regs.append([$min-x, $max-o]);
                        $replaced = True;
                    } elsif $min-x < $max-o {
                        $min-x min= $min-o;
                    }
                }
                @regs = @new-regs;
            }

            if !$replaced {
                @regs.append([$min-x, $max-x]);
                @regs = @regs.sort;
            }
        }
    }
    say $f if $f mod 100000 == 0;
    return @regs;
}

my $part-a = search-f(2000000).map(-> $a, $b { $b - $a }).sum;
my $part-b = (0..4000000).race
    .map({ search-f($_).unshift($_) })
    .grep(*.elems > 3)
    .map({ @^a[0] + (@^a[2] + 1) * 4000000 })
    .first;

say "A: ", $part-a;
say "B: ", $part-b;

say now - INIT now;
