import LeanFlagAlgebras.Flags.FlagGenerator
import LeanFlagAlgebras.Forbid.TuranDensity
import LeanFlagAlgebras.Forbid.CommonGraphs

/-! # Erdős pentagon problem: the graphs

Sets up the combinatorial data for the Erdős pentagon problem (maximum density
of the 5-cycle in triangle-free graphs): the forbidden triangle `K3` and the
pentagon `C5`. The upper bound itself is the Flagmatic certificate of
`Flagmatic/ErdosPentagon.lean`, connected to `C5` in `ErdosPentagon.lean`. -/

open FlagAlgebras SimpleGraph Compute

namespace ErdosPentagonAPI

-- Locally generate the empty-typed flags on 3, 4 and 5 vertices; the forbidden
-- `K3` and the pentagon `C5` use sizes 3 and 5.
generate_empty_typed_flags 3
generate_empty_typed_flags 4
generate_empty_typed_flags 5
generate_complete_graph 3 3

/-- The 5-cycle `C₅` on `Fin 5` (edges `01,12,23,34,40`); the target subgraph
whose triangle-free density is being maximised. -/
def C5 : SimpleGraph (Fin 5) := {
  Adj i j := match i, j with
    | 0, 1 | 1, 0 | 1, 2 | 2, 1 | 2, 3 | 3, 2 | 3, 4 | 4, 3 | 4, 0 | 0, 4 => true
    | _, _ => false
}

/-- Identifies the pentagon's flag-algebra element with the generated 5-vertex
basis element `FlagAlgebra_5_0_0_19`. -/
lemma C5_toFlagAlgebra_eq
    : C5.toFlagAlgebra = FlagAlgebra_5_0_0_19
  := by
  simp [toFlagAlgebra, C5, toFinFlag]
  congr 3
  apply Quotient.sound
  refine Nonempty.intro { graph_iso := ?_, type_preserve := List.ofFn_inj.mp rfl }
  exact {
    toFun i := match i with
      | 0 => 0 | 1 => 1 | 2 => 3 | 3 => 4 | 4 => 2
    invFun i := match i with
      | 0 => 0 | 1 => 1 | 2 => 4 | 3 => 2 | 4 => 3
    left_inv i := by fin_cases i <;> simp
    right_inv i := by fin_cases i <;> simp
    map_rel_iff' := by
      intro i j
      fin_cases i <;> fin_cases j <;> simp [Sym2Graph_5_0_0_19, mkEdgeFinset, Sym2Graph.toLabeledGraph]
  }

#print Sym2Graph_5_0_0_19 -- s(0, 1), s(0, 2), s(1, 3), s(2, 4), s(3, 4)

end ErdosPentagonAPI
