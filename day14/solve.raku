use v6;
use lib $*PROGRAM.parent.resolve.dirname;

my @lines = cache open('day14/input').lines;

my %diag;
my $max-y;

my $cx = 500; my $cy = 0;

sub display() {
    print "\n";
    for 0..$max-y -> $y {
        for 460..540 -> $x {
            my $v = %diag{"{$x},{$y}"};
            if $v {
                print $v;
            } elsif $y == $cy && $x == $cx {
                print "*";
            } elsif $y == 0 && $x == 500 {
                print "+";
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


my $part-a = 0;
my $part-b;

display();

until $cy > $max-y {
    if %diag{"{$cx},{$cy+1}"}:!exists {
        $cy += 1;
    } elsif %diag{"{$cx-1},{$cy+1}"}:!exists {
        $cy += 1;
        $cx -= 1;
    } elsif %diag{"{$cx+1},{$cy+1}"}:!exists {
        $cy += 1;
        $cx += 1;
    } else {
        %diag{"{$cx},{$cy}"} = "o";
        if $cx == 500 && $cy == 0 {
            exit;
        }
        $cx = 500;
        $cy = 0;
        $part-a += 1;
    }
}

$cy-=1;

display();

say %diag.values.grep(* eq "o").elems;

say "A: ", $part-a;
say "B: ", $part-b;

say now - INIT now;
