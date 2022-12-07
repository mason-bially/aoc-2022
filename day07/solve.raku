use v6;

my @cmds = cache open('day07/input').split('$');

my %fs;
my @cwd = ("/",);
for @cmds.grep(*.defined) -> $seq {
    my ($cmd, @res) = $seq.lines.list;
    if !$cmd {
        say $cmd, @res
    } else {
        $cmd = $cmd.Str;
        if $cmd.starts-with(' cd ..') {
            @cwd.pop()
        } elsif $cmd.starts-with(' cd /') {
            @cwd = ("/",);
        } elsif $cmd.starts-with(' cd') {
            @cwd.push($cmd.substr(4));
        } elsif $cmd.starts-with(' ls') {
            for @res -> $res {
                if !$res.starts-with('dir') {
                    my $index;
                    for @cwd -> $dir {
                        $index ~= $dir ~ "/";
                        %fs{$index} += $res.split(' ').first;
                    }
                }
            }
        } else {
            say "unknown: ", $cmd;
        }
    }
}

constant $max-space = 70000000;
constant $req-space = 30000000;
my $used-space = %fs{"//"};
say "Used Space: ", $used-space;
my $free-space = $max-space - $used-space;
say "Free Space: ", $free-space;
my $need-space = $req-space - $free-space;
say "Need Space: ", $need-space;

constant $small-dir-space = 100000;
say "A: ", sum flat %fs.pairs
    .grep(*.value.sum <= $small-dir-space)
    .map(*.value);

say "B: ", %fs.pairs
    .sort(*.value)
    .first(*.value > $need-space)
    .value;
