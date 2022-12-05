use v6;

grammar CrateLine {
    token TOP { <cell>* % ' ' }
    token cell { <crate> | <blank> }
    token crate { \[(.)\] }
    token blank { \s\s\s }
}

my ($crates, $insts) := open('day05/input.txt')
    .split("\n\n");

my %stacks;
for $crates.lines[0..*-2] -> $crate-line {
    for CrateLine.parse($crate-line).<cell>>>.<crate>.kv -> $i, $v {
        %stacks{$i+1}.unshift($v[0].Str) if $v;
    }
}

my (%stacks9000, %stacks9001) := (%stacks, %stacks)>>.deepmap(*.clone);

for $insts.lines.map(*.comb(/\d+/)>>.Int) -> ($count, $from, $to) {
    %stacks9001{$to}.append: %stacks9001{$from}.splice(*-$count);
    %stacks9000{$to}.append: %stacks9000{$from}.splice(*-$count).reverse;
}

sub stacks-code(%stacks) { %stacks.pairs.sort(*.key).map(*.value.first(:end)).join }

say "A: ", stacks-code %stacks9000;
say "B: ", stacks-code %stacks9001;
