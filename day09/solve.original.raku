use v6;
use lib $*PROGRAM.parent.resolve.dirname;

my @moves = cache open('day09/input')
    .lines
    .map(*.split(' '))
    ;

class Vec2 {
    has Int $.x;
    has Int $.y;
}

my %visited1;
my %visited9;
my @tx = [0,0,0,0,0,0,0,0,0,0]; my @ty = [0,0,0,0,0,0,0,0,0,0];

%visited1{"0-0"} = 1;
%visited9{"0-0"} = 1;

sub update-tail() {
    for 1..9 -> $i {
        my $tx := @tx[$i];
        my $ty := @ty[$i];
        my $hx := @tx[$i-1];
        my $hy := @ty[$i-1];

        my $xd = $tx - $hx;
        my $yd = $ty - $hy;
        if !(($xd.abs <= 1) && ($yd.abs <= 1)) {
            if ($xd != 0) {
                $tx++ if ($hx > $tx);
                $tx-- if ($hx < $tx);
            }
            if ($yd != 0) {
                $ty++ if ($hy > $ty);
                $ty-- if ($hy < $ty);
            }

            %visited1{"{$tx}-{$ty}"} += 1 if $i == 1;
            %visited9{"{$tx}-{$ty}"} += 1 if $i == 9;
        }
    }
}

for @moves -> ($dir, $amt) {
    for ^$amt {
        given $dir {
            when 'R' { @tx[0] += 1; update-tail(); }
            when 'L' { @tx[0] -= 1; update-tail(); }
            when 'U' { @ty[0] += 1; update-tail(); }
            when 'D' { @ty[0] -= 1; update-tail(); }
        }
    }
}

say "A: ", %visited1.elems;

say "B: ", %visited9.elems;

say now - INIT now;
