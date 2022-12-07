use v6;

my @cmds = cache open('day07/input').split('$');

my %fs;
my %fsf;
my @cwd = ("/",);
for @cmds -> $seq {
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
            say $cmd;
        }
    }
}


say "A: ", sum flat %fs.pairs
    .grep(*.values.sum <= 100000)
    .map(*.values);

say "Used Space: ", %fs{"//"};
say "Free Space: ", 70000000 - %fs{"//"};
say "Need Space: ", 30000000 - (70000000 - %fs{"//"});
my $need-space = 30000000 - (70000000 - %fs{"//"});

say "B: ", %fs.pairs
    .sort(*.value)
    .first(*.value > $need-space);
