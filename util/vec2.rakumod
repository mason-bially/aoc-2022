unit module vec2;

class Vec2 is export {
    has Int $.x;
    has Int $.y;

    method new (::?CLASS:U $VEC: $x, $y) { return $VEC.bless(:$x, :$y); }

    method size-from (::?CLASS:U $VEC: @seq) {
        $VEC.new(@seq.first.elems, @seq.elems);
    }
    method index (@seq) is raw {
        @seq[$.y][$.x]
    }

    method WHICH (Vec2:D:) {
        return "Vec2|{$.x},{$.y}"
    }

    multi method gist { "⟨{$.x},{$.y}⟩" }
    multi method Str (Vec2:D: --> Str:D) { return self.gist }

    method add ($x, $y) {
        Vec2.new(self.x + $x, self.y + $y)
    }

    method grid-iter (Vec2:D $size: Vec2 :$start = Vec2.new(0, 0)) {
        gather {
            for $start.y...$size.y-1 -> $y {
                for $start.x...$size.x-1 -> $x {
                    take Vec2.new($x, $y);
                }
            }
        }
    }

    method grid-neighbors (Vec2:D $size: Vec2 $pos, Vec2 :$start = Vec2.new(0, 0)) {
        gather {
            take Vec2.new($pos.x, $pos.y+1) if ($pos.y+1 < $size.y);
            take Vec2.new($pos.x, $pos.y-1) if ($pos.y-1 >= $start.y);
            take Vec2.new($pos.x+1, $pos.y) if ($pos.x+1 < $size.x);
            take Vec2.new($pos.x-1, $pos.y) if ($pos.x-1 >= $start.x);
        }
    }
}

class MutVec2 is Vec2 is export {
    has Int $.x is rw;
    has Int $.y is rw;
}

multi sub infix:<==> (Vec2:D $l, Vec2:D $r) is export {
    $l.x == $r.x && $l.y == $r.y
}

multi infix:<min>(Vec2:D $l, Vec2:D $r --> Vec2) is export {
    Vec2.new($l.x min $r.x, $l.y min $r.y)
}
multi infix:<max>(Vec2:D $l, Vec2:D $r --> Vec2) is export {
    Vec2.new($l.x max $r.x, $l.y max $r.y)
}

multi v2 ($x, $y) is export {
    return Vec2.new($x, $y);
}

multi v2 ($x, $y, :$mut!) is export {
    if $mut {
        return MutVec2.new($x, $y);
    } else {
        return Vec2.new($x, $y);
    }
}
