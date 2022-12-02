use v6;

# .words # spread on whitespace into array
# .split # split on string into tuple

my $script = open('day02/input.txt')
    .lines
    .map(*.words)
    .map(-> ($a, $x) { $a.ord - 'A'.ord, $x.ord - 'X'.ord })
    .cache;

constant @rps-score = [1, 2, 3];
constant @wtl-score = [6, 3, 0];

sub rpsA (($a, $x)) {
    @rps-score[$x] + @wtl-score.rotate(1-$x)[$a]
}

sub rpsB (($a, $x)) {
    @wtl-score.reverse[$x] + @rps-score.rotate($x-1)[$a]
}

say "A: {$script.map(&rpsA).sum}";
say "B: {$script.map(&rpsB).sum}";
