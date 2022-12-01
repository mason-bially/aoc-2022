use v6;

my $file = open 'day01/input.txt';

my @elves;
my $index = 0;

for $file.lines -> $line {
    if $line {
        @elves[$index] += $line;
    } else {
        $index++;
    }
}

say "A: {@elves.max}";
say "B: {@elves.sort.tail(3).sum}";
