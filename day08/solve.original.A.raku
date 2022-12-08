use v6;
use lib $*PROGRAM.parent.resolve.dirname;

# timing 
#say now - INIT now;

my @f = cache open('day08/input').lines
    .map(*.comb.map(*.ord - '0'.ord)>>.Int.Array)
    .Array;

my $vis-count;
my $high-senic;
for 0..@f-1 -> $y {
    if $y == 0 { $vis-count += @f[$y] }
    elsif $y == @f-1 { $vis-count += @f[$y] }
    else {
        for 0..(@f[$y].elems-1) -> $x {
            if $x == 0 { $vis-count += 1 }
            elsif $x == @f[$y]-1 { $vis-count += 1 }
            else {
                my $tree = @f[$y][$x].Int;
                say $y if @f[$y].elems == 0;
                if [&&] @f[0..$y-1].map(*[$x] < $tree) {
                    $vis-count++;
                } elsif [&&] @f[$y+1..*-1].map(*[$x] < $tree) {
                    $vis-count++;
                } elsif [&&] @f[$y][0..$x-1].map(* < $tree) {
                    $vis-count++;
                } elsif [&&] @f[$y][$x+1..*-1].map(* < $tree) {
                    $vis-count++;
                }
            }
        }
    }
}

say "A: ", $vis-count;
