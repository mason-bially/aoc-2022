use v6;
use lib $*PROGRAM.parent.resolve.dirname;

my @lines = cache open('day14/input').lines;

my %diag;
my $max-y;

my $cx = 500; my $cy = 0;

sub display() {
    print "\n";
    for 0..$max-y+2 -> $y {
        for 460..580 -> $x {
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
    }
}


my $part-a;
my $part-b = 0;

display();

until False {
    if $cy+1 == $max-y+2 {
        $part-a = $part-b if !$part-a;
        %diag{"{$cx},{$cy}"} = "o";
        $part-b += 1;
        $cx = 500;
        $cy = 0;
    } elsif %diag{"{$cx},{$cy+1}"}:!exists {
        $cy += 1;
    } elsif %diag{"{$cx-1},{$cy+1}"}:!exists {
        $cy += 1;
        $cx -= 1;
    } elsif %diag{"{$cx+1},{$cy+1}"}:!exists {
        $cy += 1;
        $cx += 1;
    } else {
        %diag{"{$cx},{$cy}"} = "o";
        $part-b += 1;
        if $cx == 500 && $cy == 0 {
            last;
        }
        $cx = 500;
        $cy = 0;
        say $part-b if $part-b mod 200 == 0;
    }
}

display();

say %diag.values.grep(* eq "o").elems;

say "A: ", $part-a;
say "B: ", $part-b;

say now - INIT now;
