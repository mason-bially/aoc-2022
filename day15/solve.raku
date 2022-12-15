use v6;
use lib $*PROGRAM.parent.resolve.dirname;
use util::vec2;

my @lines = cache open('day15/input').lines;

my @regs;

for @lines {
    when /'Sensor at x='(\-?\d+)', y='(\-?\d+)': closest beacon is at x='(\-?\d+)', y='(\-?\d+)/ {
        my $s = v2($0.Int, $1.Int);
        my $b = v2($2.Int, $3.Int);
        my $d = ($s.x - $b.x).abs + ($s.y - $b.y).abs;
        print $s, " "; print $d, " ";

        my $m2d = ($s.y - 2000000).abs - $d;
        if $m2d < 0 {
            my $min-x  = $s.x + $m2d;
            my $max-x  = $s.x - $m2d;

            print " [{$min-x} {$max-x}] ";

            my $replaced = False;
            if @regs {
                my @new-regs = [];
                for @regs -> $min-o, $max-o {
                    if $max-o < $min-x || $min-o > $max-x {
                        @new-regs.append([$min-o, $max-o]);
                        print "a";
                    } elsif $min-o <= $min-x && $max-o >= $max-x {
                        @new-regs.append([$min-o, $max-o]);
                        $replaced = True;
                        print "b";
                    } elsif $min-o < $min-x && $max-o < $max-x {
                        $min-x min= $min-o;
                        print "c";
                    } elsif $min-o > $min-x && $max-o > $max-x {
                        @new-regs.append([$min-x, $max-o]);
                        $replaced = True;
                        print "d";
                    } elsif $min-x < $max-o {
                        $min-x min= $min-o;
                        print "e";
                    }
                }
                @regs = @new-regs;
            }

            if !$replaced {
                @regs.append([$min-x, $max-x]);
                @regs = @regs.sort;
            }

            say @regs;
        }
        print "\n";
    }
}

my $part-a = @regs.map(-> $a, $b { $b - $a }).sum;
my $part-b;

say "A: ", $part-a;
say "B: ", $part-b;

say now - INIT now;
