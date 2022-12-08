use v6;
use lib $*PROGRAM.parent.resolve.dirname;

use day07::day07;

constant $small-dir-space = 100000;
constant $max-space = 70000000;
constant $req-space = 30000000;

class MyDevice is TerminalDevice {
    also does FsInterp[$max-space];
}

my $device = MyDevice.new.read('day07/input');

say "A: ", $device.fs-sizes.values
    .grep(* <= $small-dir-space)
    .flat.sum;

my $need-space = $device.calc-space($req-space) :display;

say "B: ", $device.fs-sizes.values
    .sort.first(* > $need-space);
