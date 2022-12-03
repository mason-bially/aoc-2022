use v6;

my $file = open 'day02/input.txt';
my $score = 0;

for $file.lines -> $line {
    my ($opp, $mine) = $line.words;
    given $mine {
        when 'X' {
            $score += 1;
            given $opp {
                when 'A' { $score += 3; }
                when 'B' { $score += 0; }
                when 'C' { $score += 6; }
            }
        }
        when 'Y' {
            $score += 2;
            given $opp {
                when 'A' { $score += 6; }
                when 'B' { $score += 3; }
                when 'C' { $score += 0; }
            }
        }
        when 'Z' {
            $score += 3;
            given $opp {
                when 'A' { $score += 0; }
                when 'B' { $score += 6; }
                when 'C' { $score += 3; }
            }
        }
    }
}

say "A: {$score}";

my $file = open 'day02/input.txt';
my $score = 0;
for $file.lines -> $line {
    my ($opp, $mine) = $line.words;
    given $mine {
        when 'X' {
            $score += 0;
            given $opp {
                when 'A' { $score += 3; }
                when 'B' { $score += 1; }
                when 'C' { $score += 2; }
            }
        }
        when 'Y' {
            $score += 3;
            given $opp {
                when 'A' { $score += 1; }
                when 'B' { $score += 2; }
                when 'C' { $score += 3; }
            }
        }
        when 'Z' {
            $score += 6;
            given $opp {
                when 'A' { $score += 2; }
                when 'B' { $score += 3; }
                when 'C' { $score += 1; }
            }
        }
    }
}
say "B: {$score}";
