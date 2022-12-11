use v6;
use lib $*PROGRAM.parent.resolve.dirname;
use MONKEY-SEE-NO-EVAL;

my @monk-listings = cache open('day11/input').split("\n\n");

my %monks;
class Monkey {
    has @.items;
    has $.op is rw;
    has $.test is rw;
    has $.test-t is rw;
    has $.test-f is rw;
}

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
                $monk.op = $value.split("=")[1].trim;
            }
            when 'Test' {
                $monk.test = $value.substr(12).Int;
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

for ^20 {
    for ^%monks.elems {
        my $monk = %monks{$_};
        %monkbus{$_} += $monk.items.elems;
        for $monk.items {
            my \old = $_;
            my $new = EVAL($monk.op);
            my $worry = $new div 3;
            if ($worry mod $monk.test == 0) {
                %monks{$monk.test-t}.items.push($worry);
            } else {
                %monks{$monk.test-f}.items.push($worry);
            }
        }
        $monk.items = [];
        say %monkbus;
    }
    say $_;
}

say "A: ", %monkbus.values.sort();


say now - INIT now;
