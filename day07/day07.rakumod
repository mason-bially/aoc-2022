unit module day07;

class TerminalDevice is export {
    method read ($file) {
        for open($file).split('$').grep(* ne "") {
            my ($cmd, @res) = .trim.lines.list;
            self.sim($cmd, @res)
        }; self
    }

    multi method sim ($cmd, |) { say "unknown: ", $cmd }
    multi method sim-res ($cmd, $res) { say "unknown '{$cmd}': ", $res }
}

role FsInterp[$max-space = 70000000] is export {
    has %.fs-sizes;
    has @.cwd = ("",);

    method apply-cwd(&fn) {
        for @.cwd -> $dir {
            state $index ~= $dir ~ "/";
            &fn(%.fs-sizes{$index});
        }
    }

    multi method sim ($ where /^'cd '(\w+)/, |) { @.cwd.push($0) }
    multi method sim ($ where 'cd ..', |) { @.cwd.pop() }
    multi method sim ($ where 'cd /', |) { @.cwd = ("",) }

    multi method sim ($ where 'ls', *@res) { for @res { self.sim-res('ls', $_) } }

    multi method sim-res ('ls', $res where /^(\d+)' '(\w+)/) { self.apply-cwd(* += $0) }
    multi method sim-res ('ls', $res where /^'dir '(\w+)/) { }

    method calc-space($req-space = 30000000, :$display) {
        my $used-space = $.fs-sizes{"/"};
        say "Used Space: ", $used-space if $display;
        my $free-space = $max-space - $used-space;
        say "Free Space: ", $free-space if $display;
        my $need-space = $req-space - $free-space;
        say "Need Space: ", $need-space if $display;
        $need-space
    }
}
