-- Copyright (c) 2017 Scott Morrison. All rights reserved.
-- Released under Apache 2.0 license as described in the file LICENSE.
-- Authors: Scott Morrison

import .at_least_one 

open tactic

meta def automatic_induction_at (h : expr) : tactic unit :=
do t ← infer_type h,
match t with
| `(unit)      := induction h >> skip
| `(punit)     := induction h >> skip
| `(false)     := induction h >> skip
| `(empty)     := induction h >> skip
| `(fin nat.zero) := induction h >> `[cases is_lt]
| `(ulift _)   := induction h >> skip
| `(plift _)   := induction h >> skip
| `(eq _ _)    := induction h >> skip
| `(prod _ _)  := induction h >> skip
| `(and _ _)   := induction h >> skip
| `(sigma _)   := induction h >> skip
| `(subtype _) := induction h >> skip
| _              := failed
end

meta def automatic_induction : tactic unit :=
do l ← local_context,
   at_least_one (l.reverse.map(λ h, automatic_induction_at h))