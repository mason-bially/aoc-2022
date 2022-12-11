use v6;

my $mod = 1;
my &op;

sub test ($i, &op, &bl) {
    my $v = &op($i);
    say "a: {&bl($v mod $mod)} != {&bl($v)}";
    say "b: {&bl($v) mod $mod} != {&bl($v)}";
}

sub MAIN($num, $div) {
    $mod = $div;
    &op = { $_ * $_ };
    test($num, &op, { $^worry mod $mod });
}
