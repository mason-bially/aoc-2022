use v6;
use lib $*PROGRAM.parent.resolve.dirname;

my @monk-listings = cache open('day11/input').split("\n\n");

my %monks;
class Monkey {
    has @.items;
    has &.op is rw;
    has &.test is rw;
}

my $mod-cap = 1;
my $monk-index = 0;
for @monk-listings {
    my $monk = Monkey.new();
    my $test-t; my $test-f; my $test-mod;
    for .lines {
        my ($key, $value) = .split(":")>>.trim;
        given $key {
            when 'Starting items' { $monk.items = $value.split(", ")>>.Int }
            when 'Test' { $test-mod = $value.substr(12).Int; }
            when 'If true' { $test-t = $value.substr(15).Int; }
            when 'If false' { $test-f = $value.substr(15).Int; }
            when 'Operation' {
                my @ops = $value.split("=")[1].trim.split(" ")>>.Str.list;
                given @ops[2] {
                    when 'old' {
                        given @ops[1] {
                            when "+" { $monk.op = -> Int $old { ($old + $old).narrow } }
                            when "*" { $monk.op = -> Int $old { ($old * $old).narrow } }
                        }
                    }
                    when /(\d+)/ {
                        my $value = $0.Int;
                        given @ops[1] {
                            when "+" { $monk.op = -> Int $old { ($old + $value).narrow } }
                            when "*" { $monk.op = -> Int $old { ($old * $value).narrow } }
                        }
                    }
                }
            }
        }
    }
    $monk.test = -> $worry {
        if ($worry mod $test-mod) {
            %monks{$test-f}.items.push($worry);
        } else {
            %monks{$test-t}.items.push($worry);
        }
    };
    $mod-cap *= $test-mod;
    %monks{$monk-index++} = $monk;
}

say $mod-cap;
sub monkey-business($rounds, &worry-fix) {
    my %monkbus; my $count = 0;
    while $count < $rounds {
        for ^%monks.elems {
            my $monk = %monks{$_};
            %monkbus{$_} += $monk.items.elems;
            for $monk.items {
                &($monk.test)(&worry-fix(&($monk.op)($_)));
            }
            $monk.items = [];
        }
        $count += 1;
    }
    my @bus = %monkbus.values.sort().reverse;
    say @bus;
    @bus[0] * @bus[1];
}

say "A: ", monkey-business(20, { $^worry div 3 });
say "B: ", monkey-business(10000, -> $worry { $worry mod $mod-cap });

say now - INIT now;
