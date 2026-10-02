-- Utils
import LeanFlagAlgebras.Utils.Combinations
import LeanFlagAlgebras.Utils.LinExtension
import LeanFlagAlgebras.Utils.MultinomialCoefficient
import LeanFlagAlgebras.Utils.Partitions
import LeanFlagAlgebras.Utils.QuotientGraph
import LeanFlagAlgebras.Utils.SubgraphUtil
import LeanFlagAlgebras.Utils.TacticChoose

-- GraphAlgebra
import LeanFlagAlgebras.GraphAlgebra.SubgraphDensity
import LeanFlagAlgebras.GraphAlgebra.GraphAlgebra

-- FlagAlgebra
import LeanFlagAlgebras.FlagAlgebra.FlagDef
import LeanFlagAlgebras.FlagAlgebra.SubflagDensity
import LeanFlagAlgebras.FlagAlgebra.SubflagListDensity
import LeanFlagAlgebras.FlagAlgebra.SubflagListDensityProp
import LeanFlagAlgebras.FlagAlgebra.FlagAlgebra
import LeanFlagAlgebras.FlagAlgebra.FlagOperators
import LeanFlagAlgebras.FlagAlgebra.PositiveHom
import LeanFlagAlgebras.FlagAlgebra.FlagSequence
import LeanFlagAlgebras.FlagAlgebra.RandomHom
import LeanFlagAlgebras.FlagAlgebra.QuadraticForm
import LeanFlagAlgebras.FlagAlgebra.Compute.Basic
import LeanFlagAlgebras.FlagAlgebra.Compute.FastIso
import LeanFlagAlgebras.FlagAlgebra.Compute.Downward
import LeanFlagAlgebras.FlagAlgebra.Compute.FlagDensity

-- BitMask (graphs as bit masks: kernel-checked canonicalization sweeps and the
-- density bridges behind the decide +kernel routes of the K5/C5 examples)
import LeanFlagAlgebras.BitMask.Mask2
import LeanFlagAlgebras.BitMask.CanonSmall
import LeanFlagAlgebras.BitMask.Canon2Data
import LeanFlagAlgebras.BitMask.Canon3Data
import LeanFlagAlgebras.BitMask.Canon4Data
import LeanFlagAlgebras.BitMask.Canon5Data
import LeanFlagAlgebras.BitMask.Canon5
import LeanFlagAlgebras.BitMask.Canon6Data
import LeanFlagAlgebras.BitMask.Canon6Checker
import LeanFlagAlgebras.BitMask.Canon6Sweep0
import LeanFlagAlgebras.BitMask.Canon6Sweep1
import LeanFlagAlgebras.BitMask.Canon6Sweep2
import LeanFlagAlgebras.BitMask.Canon6Sweep3
import LeanFlagAlgebras.BitMask.Canon6
import LeanFlagAlgebras.BitMask.Density
import LeanFlagAlgebras.BitMask.Density6
import LeanFlagAlgebras.BitMask.MaskBridge
import LeanFlagAlgebras.BitMask.RootedMask
import LeanFlagAlgebras.BitMask.RootedDensity
import LeanFlagAlgebras.BitMask.RootedCanon
import LeanFlagAlgebras.BitMask.RCanon1_2Data
import LeanFlagAlgebras.BitMask.RCanon1_3Data
import LeanFlagAlgebras.BitMask.RCanon1_5Data
import LeanFlagAlgebras.BitMask.RCanon2_3Data
import LeanFlagAlgebras.BitMask.RCanon2_4Data
import LeanFlagAlgebras.BitMask.RCanon3_4Data
import LeanFlagAlgebras.BitMask.RCanon3_5Data
import LeanFlagAlgebras.BitMask.RCanon2_6Data
import LeanFlagAlgebras.BitMask.RCanon2_6Checker
import LeanFlagAlgebras.BitMask.RCanon2_6Sweep0
import LeanFlagAlgebras.BitMask.RCanon2_6Sweep1
import LeanFlagAlgebras.BitMask.RCanon2_6Sweep2
import LeanFlagAlgebras.BitMask.RCanon2_6Sweep3
import LeanFlagAlgebras.BitMask.RCanon2_6
import LeanFlagAlgebras.BitMask.RootedCount
import LeanFlagAlgebras.BitMask.RootedMatrix
import LeanFlagAlgebras.BitMask.RootedAccept
import LeanFlagAlgebras.BitMask.RootedHfree
import LeanFlagAlgebras.BitMask.SubHfree

-- Flags
import LeanFlagAlgebras.Flags.FlagGenerator
import LeanFlagAlgebras.Flags.Densities.DensityThmGenerator
import LeanFlagAlgebras.Flags.Densities.MulThmGenerator

-- API
import LeanFlagAlgebras.Automation.Basic
import LeanFlagAlgebras.Automation.ExprHelpers
import LeanFlagAlgebras.Automation.FlagExpand
import LeanFlagAlgebras.Automation.FlagMulReduce
import LeanFlagAlgebras.Automation.FlagSumSort
import LeanFlagAlgebras.Automation.K4freeP4
import LeanFlagAlgebras.Automation.CompleteGraphFreeP4
import LeanFlagAlgebras.Automation.Matrix.PosSemiDef
import LeanFlagAlgebras.Automation.FlagCertificate

-- MantelTheorem
import LeanFlagAlgebras.MantelTheorem.FlagDef
import LeanFlagAlgebras.MantelTheorem.FlagDensity
import LeanFlagAlgebras.MantelTheorem.FlagMul
import LeanFlagAlgebras.MantelTheorem.Lemmas
import LeanFlagAlgebras.MantelTheorem.MantelTheorem
import LeanFlagAlgebras.MantelTheorem.GoodmanRamsey
import LeanFlagAlgebras.MantelTheorem.GoodmanBound

-- Turan
import LeanFlagAlgebras.Turan.GeneralizedTuran

-- Forbid
import LeanFlagAlgebras.Forbid.Basic
import LeanFlagAlgebras.Forbid.TuranDensity
import LeanFlagAlgebras.Forbid.CommonGraphs

 -- ErdosPentagon
import LeanFlagAlgebras.ErdosPentagon.FlagDef
import LeanFlagAlgebras.ErdosPentagon.ErdosPentagon

-- Flagmatic (the seven paper case studies, in the order of the paper's Section 5.4 table).
-- Each is proved by `flag_certificate`, which reads the committed certificate JSON at
-- elaboration time; `flag_certificate?` materializes the explicit script on demand.
import LeanFlagAlgebras.Flagmatic.Mantel
import LeanFlagAlgebras.Flagmatic.K3freeP3
import LeanFlagAlgebras.Flagmatic.K3freeC4
import LeanFlagAlgebras.Flagmatic.K4freeEdge
import LeanFlagAlgebras.Flagmatic.ErdosPentagon
import LeanFlagAlgebras.Flagmatic.K5freeEdge
import LeanFlagAlgebras.Flagmatic.C5freeEdge

-- MetaTheory (paper.tex §1–8, plus §9 pinning obstruction): complete and sorry-free
import LeanFlagAlgebras.MetaTheory

/-! # LeanFlagAlgebras — top-level import manifest

This file is the root module of the project and the single source of truth for
what is in the build (the `@[default_target]` library root in `lakefile.lean`).
It does no work itself: it only `import`s every module so building this file
builds the whole development.

The imports above are grouped by layer, roughly from foundations upward:

* **Utils** — general-purpose combinatorics, matrices/PSD, partitions, tactics.
* **GraphAlgebra** — subgraph densities and the graph algebra.
* **FlagAlgebra** — flag definitions, densities, the flag algebra, positive
  homomorphisms, random homomorphisms, quadratic forms, and `Compute.*`.
* **BitMask** — graphs encoded as natural numbers, kernel-checked
  canonicalization sweeps, and the density bridges that let the generators
  discharge every finite identity by `decide +kernel`.
* **Flags** — the flag/density loaders and generated flag definitions.
* **API** — the reusable proof-automation layer (`Basic`, `ExprHelpers`,
  `FlagExpand`, `FlagMulReduce`, `FlagSumSort`) and the per-problem
  density-bound proofs (ErdosPentagon, Mantel, C4 Turán, K4-free P₄).
* **MantelTheorem / ErdosPentagon / Turan / Forbid** — the
  problem-specific developments and the `Forbid` (almost-sure inequality under
  a forbidden subgraph) foundation they build on.

The `Archive.*` modules are intentionally excluded from the build (kept as
commented-out imports below for reference only). -/

-- Archive imports
-- import LeanFlagAlgebras.Archive.BoolAlgebra
-- import LeanFlagAlgebras.Archive.DefinitionImpactOnProofs
-- import LeanFlagAlgebras.Archive.Compute.Basic
-- import LeanFlagAlgebras.Archive.Compute.Basic_
-- import LeanFlagAlgebras.Archive.Compute.Downward
-- import LeanFlagAlgebras.Archive.Compute.FlagDensity
-- import LeanFlagAlgebras.Archive.Compute.LabeledGraphListCount
-- import LeanFlagAlgebras.Archive.MantelTheorem.FlagDefs
-- import LeanFlagAlgebras.Archive.MantelTheorem.Downward
-- import LeanFlagAlgebras.Archive.MantelTheorem.FlagDensity
-- import LeanFlagAlgebras.Archive.MantelTheorem.FlagIso
-- import LeanFlagAlgebras.Archive.MantelTheorem.FlagIso_old
-- import LeanFlagAlgebras.Archive.MantelTheorem.FlagMuls
-- import LeanFlagAlgebras.Archive.MantelTheorem.MantelTheorem
-- import LeanFlagAlgebras.Automation.ErdosPentagonAPI
-- import LeanFlagAlgebras.Automation.MantelTheoremAPI
-- import LeanFlagAlgebras.Automation.C4TuranAPI
