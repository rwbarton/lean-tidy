import tidy.rewrite_all_wrappers
import data.vector
structure F :=
(a : ℕ)
(v : vector ℕ a)
(p : v.val = [])

example (f : F) : f.v.val = [] :=
begin
perform_nth_rewrite 0 [f.p],
end

private structure cat :=
  (O : Type)
  (H : O → O → Type)
  (i : Π o : O, H o o)
  (c : Π {X Y Z : O} (f : H X Y) (g : H Y Z), H X Z)
  (li : Π {X Y : O} (f : H X Y), c (i X) f = f)
  (ri : Π {X Y : O} (f : H X Y), c f (i Y) = f)
  (a : Π {W X Y Z : O} (f : H W X) (g : H X Y) (h : H Y Z), c (c f g) h = c f (c g h))

open tactic

set_option pp.implicit true
private example (C : cat) (W X Y Z : C.O) (f : C.H X Y) (g : C.H W X) (h k : C.H Y Z) : C.c (C.c g f) h = C.c g (C.c f h) :=
begin
 perform_nth_rewrite 0 [C.a],
end


private example (C : cat) (X Y : C.O) (f : C.H X Y) : C.c f (C.i Y) = f :=
begin
  perform_nth_rewrite 0 [C.ri],
end

axiom foo : [1] = [2]

example : [[1], [1], [1]] = [[1], [2], [1]] :=
begin
  nth_rewrite_lhs 1 [foo],
end

