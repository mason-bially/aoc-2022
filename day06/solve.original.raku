use v6;

my @data = cache open('day06/input').lines.first;

say "A: ", @data.comb
    .rotor(4 => -3)
    .pairs
    .first({$_.value.Set == 4})
    .key + 4;

say "B: ", @data.comb
    .rotor(14 => -13)
    .pairs
    .first({$_.value.Set == 14})
    .key + 14;
