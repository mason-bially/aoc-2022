use v6;

# .words # spread on whitespace into array
# .split # split on string into tuple

my $file = open 'day02/input.txt';
my $scoreA = 0;
my $scoreB = 0;

for $file.lines -> $line {
    my ($opp, $mine) = $line.words;
    given $mine {
        when 'X' {
            $scoreA += 1; $scoreB += 0;
            given $opp {
                when 'A' { $scoreA += 3; $scoreB += 3; }
                when 'B' { $scoreA += 0; $scoreB += 1; }
                when 'C' { $scoreA += 6; $scoreB += 2; }
            }
        }
        when 'Y' {
            $scoreA += 2; $scoreB += 3;
            given $opp {
                when 'A' { $scoreA += 6; $scoreB += 1; }
                when 'B' { $scoreA += 3; $scoreB += 2; }
                when 'C' { $scoreA += 0; $scoreB += 3; }
            }
        }
        when 'Z' {
            $scoreA += 3; $scoreB += 6;
            given $opp {
                when 'A' { $scoreA += 0; $scoreB += 2; }
                when 'B' { $scoreA += 6; $scoreB += 3; }
                when 'C' { $scoreA += 3; $scoreB += 1; }
            }
        }
    }
}

say "A: {$scoreA}";
say "B: {$scoreB}";
