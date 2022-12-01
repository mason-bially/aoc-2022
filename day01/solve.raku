use v6;

my @elves = open('day01/input.txt').split("\n\n").map(*.lines.sum);

say "A: {@elves.max}";
say "B: {@elves.sort.tail(3).sum}";
