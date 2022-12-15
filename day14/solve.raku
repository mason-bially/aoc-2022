use v6;
use lib $*PROGRAM.parent.resolve.dirname;
use util::vec2;

my @lines = cache open('day14/input').lines;

my $max = v2(500,0);
my $min = v2(500,0);

for @lines {
    for .split(" -> ") {
        my ($nx, $ny) = .split(",")>>.Int;
        my $v = v2($nx, $ny);
        $max max= $v;
        $min min= $v;
    }
}

enum Cell (
    Air => 0,
    Sand => 1,
    Wall => 2
);

my @a = [];

for $max.add(2, 3).grid-iter():start($min.add(-1, 0)) {
    $_.index(@a) = Air;
}

for @lines {
    my $px; my $py;
    for .split(" -> ") {
        my ($nx, $ny) = .split(",")>>.Int;
        if $px && $py {
            if $px eq $nx {
                for $py...$ny -> $y {
                    Vec2.new($px, $y).index(@a) = Wall;
                }
            } elsif $py eq $ny {
                for $px...$nx -> $x {
                    Vec2.new($x, $py).index(@a) = Wall;
                }
            }
        }
        $px = $nx; $py = $ny;
    }
}

my MutVec2 $c = v2(500,0):mut;

sub display() {
    my $py;
    for $max.add(2, 3).grid-iter():start($min.add(-1, 0)) {
        print "\n" if $py != .y;
        if .y == $c.y && .x == $c.x {
            print "*";
        } elsif .y == 0 && .x == 500 {
            print "+";
        } elsif .y == $max.y+2 {
            print "_";
        } else {
            given .index(@a) {
                when Air { print "." }
                when Wall { print "#" }
                when Sand { print "o" }
            }
        }
        $py = .y;
    }
    print "\n";
}


my $stable;
my $part-a;
my $part-b = 0;

display();

sub place() {
    $c.index(@a) = Sand;
    $stable += 1;
    $c.x = 500;
    $c.y = 0;
}

my $src = Vec2.new(500, 0);
until $src.index(@a) != Air {
    if $c.y+1 == $max.y+2 {
        if !$part-a {
            $part-a = $stable;
            say "A: ", $part-a;
            display();
        }
        place();
    } elsif Vec2.new($c.x, $c.y+1).index(@a) == Air {
        $c.y += 1;
    } elsif Vec2.new($c.x-1, $c.y+1).index(@a)  == Air {
        $c.y += 1;
        $c.x -= 1;
    } elsif Vec2.new($c.x+1, $c.y+1).index(@a)  == Air {
        $c.y += 1;
        $c.x += 1;
    } else {
        place();
    }
}

display();
$part-b = $stable;

say "A: ", $part-a;
say "B: ", $part-b;

say now - INIT now;
