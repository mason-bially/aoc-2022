use v6;
use lib $*PROGRAM.parent.resolve.dirname;
use MONKEY-SEE-NO-EVAL;

my @monk-listings = cache open('day11/input').split("\n\n");

my $part-a;
my $part-b;

my %monks;
class Monkey {
    has @.items;
    has &.op is rw;
    has $.test is rw;
    has $.test-t is rw;
    has $.test-f is rw;
}

my $mod-cap = 1;
my $monk-index = 0;
for @monk-listings {
    my $monk = Monkey.new();
    for .lines {
        my ($key, $value) = .split(":")>>.trim;
        given $key {
            when 'Starting items' {
                $monk.items = $value.split(", ")>>.Int
            }
            when 'Operation' {
                my @ops = $value.split("=")[1].trim.split(" ")>>.Str.list;
                given @ops[2] {
                    when 'old' {
                        given @ops[1] {
                            when "+" { $monk.op = -> $old { $old + $old } }
                            when "*" { $monk.op = -> $old { $old * $old } }
                        }
                    }
                    when /(\d+)/ {
                        my $value = $0;
                        given @ops[1] {
                            when "+" { $monk.op = -> $old { $old + $value } }
                            when "*" { $monk.op = -> $old { $old * $value } }
                        }
                    }
                }
            }
            when 'Test' {
                $monk.test = $value.substr(12).Int;
                $mod-cap *= $monk.test;
            }
            when 'If true' {
                $monk.test-t = $value.substr(15).Int;
            }
            when 'If false' {
                $monk.test-f = $value.substr(15).Int;
            }
        }
    }
    %monks{$monk-index++} = $monk;
}

say %monks;

my %monkbus;
my $count = 0;
while $count < 10000 {
    for ^%monks.elems {
        my $monk = %monks{$_};
        %monkbus{$_} += $monk.items.elems;
        for $monk.items {
            my &op = $monk.op;
            my $worry = &op($_) mod $mod-cap;
            if ($worry mod $monk.test == 0) {
                %monks{$monk.test-t}.items.push($worry);
            } else {
                %monks{$monk.test-f}.items.push($worry);
            }
        }
        $monk.items = [];
    }
    $count += 1;
    say $count if ($count mod 100 == 0);
}

my @bus = %monkbus.values.sort().reverse;
say "A: ", @bus[0] * @bus[1];


say now - INIT now;
