use v6;
use lib $*PROGRAM.parent.resolve.dirname;

my @lines = cache open('day10/input').lines;

my $clock = 0;
my $regX = 1;

my $sig-strength;
sub clock-cycle() {
    if ((++$clock) - 20) mod 40 == 0 && $clock <= 220 {
        $sig-strength += $regX * $clock;
    }

    if ((($clock - 1) mod 40) - $regX).abs < 2 {
        print "#"
    } else {
        print "."
    }
    print "\n" if $clock mod 40 == 0;
}

for @lines {
    when "noop" {
        clock-cycle();
    }
    when /'addx '(\-?\d+)/ {
        clock-cycle();
        clock-cycle();
        $regX += $0;
    }
}

say "A: ", $sig-strength;

say now - INIT now;
