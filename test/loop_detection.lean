import tidy.loop_detection

namespace tidy.test
open tactic

meta def interactive_simp := `[simp]

lemma looping_test_1 (a : empty): 1 = 1 :=
begin
success_if_fail { detect_looping $ skip },
success_if_fail { detect_looping $ skip >> skip },
refl
end
lemma looping_test_2 (a : empty): 1 = 1 :=
begin
detect_looping $ interactive_simp
end

end tidy.test