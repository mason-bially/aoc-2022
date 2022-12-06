use v6;

# lesson learned: Get over it and comb!
# lesson learned: Gotta use `.lines` to get actual text, probably use IO for safety?
# lesson learned: reduce is stupid, just call `.Set`

my @data = cache open('day06/input').lines.first.comb;

sub header-index (@data, Int:D :$length) {
    @data.rotor($length => (1 - $length))
        .pairs.first(*.value.Set == $length)
        .key + $length
}

say "A: ", header-index(@data) :4length;
say "B: ", header-index(@data) :14length;
