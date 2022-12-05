use v6;

my ($crates, $insts) = open('day05/input.txt')
    .split("\n\n");

my %stacks;

grammar CrateLine {
    token TOP { <cell>* % ' ' }
    token cell { <crate> | <blank> }
    token crate { \[(.)\] }
    token blank { \s\s\s }
}

for $crates.lines[0..*-2] -> $crate-line {
    my $crate-match = CrateLine.parse($crate-line);
    my $stack-index = 0;
    for $crate-match.<cell>.list -> $cell {
        $stack-index++;
        if ($cell.<crate>) {
            my $value = $cell.<crate>[0].Str;
            %stacks{$stack-index}.push($value);
        }
    }
}

my %stacks9000;
my %stacks9001;

for %stacks.pairs -> $pair {
    %stacks9000{$pair.key} = $pair.value.reverse.Array;
    %stacks9001{$pair.key} = %stacks9000{$pair.key}.clone;
}

say $crates;
say %stacks;

grammar MoveLine {
    token TOP { 'move '(\d+)' from '(\d+)' to '(\d+) }
}

for $insts.lines -> $inst-line {
    my $inst-match = MoveLine.parse($inst-line);
    my ($count, $from, $to) = $inst-match.values>>.Int;

    %stacks9001{$to}.append: %stacks9001{$from}.splice((%stacks9001{$from}.elems-$count) max 0);

    while $count-- && %stacks9000{$from} {
        %stacks9000{$to}.push: pop %stacks9000{$from};
    }
}

say %stacks9000;
say %stacks9001;

say "A: ", %stacks9000
    .pairs
    .sort(*.key)
    .map(*.value[*-1])
    .join;

say "B: ", %stacks9001
    .pairs
    .sort(*.key)
    .map(*.value[*-1])
    .join;
