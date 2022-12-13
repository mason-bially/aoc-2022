use v6;
use lib $*PROGRAM.parent.resolve.dirname;

grammar PacketGrammar  {
    rule TOP {
        <expr>+
    }
    rule expr {
        | <atom>
        | '[' ~ ']' [<expr>+ % ',']?
    }
    token atom { \d+ }
}

class PacketActions {
    method expr ($/) {
        if $/<atom> {
            make $/<atom>.made
        } elsif $/<expr> {
            make $/<expr>».made
        } else {
            make []
        }
    }
    method atom($/) {
        make +$/
    }

    method TOP ($match) {
        $match.make: $match<expr>».made.first
    }
}

sub cmp($a, $b) {
    if $a ~~ Int {
        if $b ~~ Int {
            if $a < $b {
                return Order::Less;
            } elsif $a > $b {
                return Order::More;
            } else {
                return Order::Same;
            }
        } else {
            return cmp([$a], $b)
        }
    } else {
        if $b ~~ Int {
            return cmp($a, [$b])
        } else {
            my $i = 0;
            my $ea = $a.elems;
            my $eb = $b.elems;
            while $i < $ea && $i < $eb {
                my $c = cmp($a[$i], $b[$i]);
                return $c if $c != 0;
                $i += 1;
            }
            return Order::Less if $ea < $eb;
            return Order::More if $ea > $eb;
            return Order::Same;
        }
    }
}

my @lines = cache open('day13/input').lines
    .grep(* !~~ "")
    .map({ PacketGrammar.parse($_, actions => PacketActions).made });

my $part-a = @lines
    .map(-> $a, $b { cmp($a, $b) })
    .pairs.grep(*.value == Order::Less)
    .map(*.key + 1).sum();

my $d2 = [[2]];
my $d6 = [[6]];
@lines.append($d2, $d6);

my @ordered = @lines.sort(-> $a, $b { cmp($a, $b) });
$d2 = @ordered.pairs.first(*.value === $d2).key + 1;
$d6 = @ordered.pairs.first(*.value === $d6).key + 1;

my $part-b = $d2 * $d6;

say "A: ", $part-a;
say "B: ", $part-b;

say now - INIT now;
