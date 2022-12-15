use v6;
use lib $*PROGRAM.parent.resolve.dirname;

use util::vec2;

my $cur = Vec2.new(2, 3);
my $pre = Vec2.new(2, 3);
my $start = Vec2.new(-4, 5);
my $end = Vec2.new(4, -5);

say "\$cur == \$pre ", $cur == $pre;
say "\$cur === \$pre ", $cur === $pre;
say $start == $end;
say $cur, $pre, $start, $end;

