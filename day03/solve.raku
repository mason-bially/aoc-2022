use v6;

# lesson learned: comb for characters
# lesson learned: sum counts list sizes unless flattened
# lesson learned: grep for filter


my @sacks = cache open('day03/input.txt')
    .lines
    .map(*.trans('a'..'z' => 1.chr..26.chr, 'A'..'Z' => 27.chr..52.chr).ords)
    ;

say "A: ", sum flat list @sacks
    .map({ @^s[0..* div 2 - 1], @^s[* div 2..* - 1] })
    .map({ cross(@^p).flat.grep(* == *).map(*.head).unique })
    ;

say "B: ", sum flat list @sacks
    .map((*<> X *<> X *<>).flat.grep(* == * == *).map(*.head).unique)
    ;
