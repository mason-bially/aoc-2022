use v6;

# lesson learned: comb for characters
# lesson learned: sum counts list sizes unless flattened
# lesson learned: grep for filter

my @sacks = cache open('day03/input.txt')
    .lines
    .map(*.trans('a'..'z' => 1.chr..26.chr, 'A'..'Z' => 27.chr..52.chr).ords)
    ;

say "A: ", sum @sacks
    .map({ $_[0..* div 2 - 1], $_[* div 2..* - 1] })
    .map(*>>.unique.reduce: &infix:<(+)>)
    .map: *.max(*.value).key;

say "B: ", sum @sacks
    .map(*.unique)
    .map(* (+) * (+) *)
    .map: *.max(*.value).key;
