use v6;

my $script = open('day02/input.txt')
    .lines
    .map(*.words)
    .map(-> ($a,$x) { $a.ord - 'A'.ord, $x.ord - 'X'.ord })
    .cache;

constant @rps = [1, 2, 3];
constant @wtl = [6, 3, 0];

say "A: ",
    $script
    .map(-> ($a,$x) { @rps[$x] + @wtl.rotate(1-$x)[$a] })
    .sum;

say "B: ", 
    $script
    .map(-> ($a,$x) { @wtl.reverse[$x] + @rps.rotate($x-1)[$a] })
    .sum;
