use v6;

my $script = cache open('day02/input.txt')
    .lines.map(*.words)
    .map(-> ($a,$x) { $a.ord - 'A'.ord, $x.ord - 'X'.ord });

constant @rps = [1, 2, 3];
constant @wtl = [6, 3, 0];

say "A: ", sum $script
    .map(-> ($a,$x) { @rps[$x] + @wtl.rotate(1-$x)[$a] });

say "B: ", sum $script
    .map(-> ($a,$x) { @wtl.reverse[$x] + @rps.rotate($x-1)[$a] });
