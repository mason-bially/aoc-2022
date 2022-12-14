use v6;
use lib $*PROGRAM.parent.resolve.dirname;

my @lines = cache open('day14/input').lines;

my %diag;
my $max-y;
my $max-x;
my $min-x;

my $cx = 500; my $cy = 0;

sub display() {
    print "\n";
    for 0..$max-y+2 -> $y {
        for $min-x-1..$max-x+1 -> $x {
            my $v = %diag{"{$x},{$y}"};
            if $v {
                print $v;
            } elsif $y == $cy && $x == $cx {
                print "*";
            } elsif $y == 0 && $x == 500 {
                print "+";
            } elsif $y == $max-y+2 {
                print "_";
            } else {
                print ".";
            }
        }
        print "\n";
    }
    print "\n";
}

for @lines {
    my $px; my $py;
    for .split(" -> ") {
        my ($nx, $ny) = .split(",")>>.Int;

        if $px && $py {
            if $px eq $nx {
                for $py...$ny -> $y {
                    %diag{"{$px},{$y}"} = '#';
                }
            } elsif $py eq $ny {
                for $px...$nx -> $x {
                    %diag{"{$x},{$py}"} = '#';
                }
            }
        }
        $px = $nx; $py = $ny;
        $max-y max= $ny;
        $max-x max= $nx;
        $min-x min= $nx;
    }
}

my $stable;
my $part-a;
my $part-b = 0;

display();

sub place() {
    %diag{"{$cx},{$cy}"} = "o";
    $stable += 1;
    $cx = 500;
    $cy = 0;
}

until %diag{"500,0"}:exists {
    if $cy+1 == $max-y+2 {
        if !$part-a {
            $part-a = $stable;
            say "A: ", $part-a;
            display();
        }
        place();
    } elsif %diag{"{$cx},{$cy+1}"}:!exists {
        $cy += 1;
    } elsif %diag{"{$cx-1},{$cy+1}"}:!exists {
        $cy += 1;
        $cx -= 1;
    } elsif %diag{"{$cx+1},{$cy+1}"}:!exists {
        $cy += 1;
        $cx += 1;
    } else {
        place();
    }
}

display();
$part-b = $stable;

say "A: ", $part-a;
say "B: ", $part-b;

say now - INIT now;
