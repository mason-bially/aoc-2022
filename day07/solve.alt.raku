use v6;

my @cmds = cache open('day07/input').split('$');

my %fs-sizes;
my @cwd = ("",);
for @cmds.grep(* ne "") -> $seq {
    my ($cmd, @res) = $seq.trim.lines.list;
    given $cmd {
        when 'cd ..' { @cwd.pop() }
        when 'cd /' {  @cwd = ("",) }
        when /^'cd '(\w+)/ { @cwd.push($0) }
        when 'ls' {
            for @res {
                when /^(\d+)' '(\w+)/ {
                    for @cwd -> $dir {
                        state $index ~= $dir ~ "/";
                        %fs-sizes{$index} += $0;
                    }
                }
            }
        }
        default { say "unknown: ", $_ }
    }
}

constant $max-space = 70000000;
constant $req-space = 30000000;
my $used-space = %fs-sizes{"/"};
say "Used Space: ", $used-space;
my $free-space = $max-space - $used-space;
say "Free Space: ", $free-space;
my $need-space = $req-space - $free-space;
say "Need Space: ", $need-space;

constant $small-dir-space = 100000;
say "A: ", %fs-sizes.values
    .grep(* <= $small-dir-space)
    .flat.sum;

say "B: ", %fs-sizes.values
    .sort.first(* > $need-space);
