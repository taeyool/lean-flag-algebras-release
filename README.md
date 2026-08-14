# lean-flag-algebras

A [Lean 4](https://leanprover.org/) formalization of **flag algebras**
([Razborov, 2007](https://people.cs.uchicago.edu/~razborov/files/flag.pdf)),
together with a verified pipeline that turns semidefinite-programming
certificates into machine-checked extremal-combinatorics proofs.

This repository is the public artifact accompanying our paper on formalized
flag algebras. Its centrepiece — the main contribution of the paper — is the
**Flagmatic-to-Lean pipeline** ([`LeanFlagAlgebras/Flagmatic/`](LeanFlagAlgebras/Flagmatic/README.md)):
a certificate-to-proof compiler, invoked as the elaboration-time tactic
**`flag_certificate`**, that turns SDP certificates produced by
[Flagmatic](https://github.com/jsliacan/flagmatic) into complete Lean proofs
of Turán-type density bounds, evaluated end-to-end on seven case studies.
The theorem statement is fixed in the source file; the certificate enters
only as untrusted hint data from which the proof is synthesized.
Supporting it are the core flag-algebra library, a tactic layer, the
meta-theory of forbidden-subgraph reasoning, and hand-developed lower bounds
completing two Turán densities.

## Main results

The seven certificate-generated theorems (the paper's case table; SDP block
data in the [Flagmatic README](LeanFlagAlgebras/Flagmatic/README.md)). Each
theorem `<Name>_flagAlgebra` lives in namespace `<Name>` and is proved by
`flag_certificate` from the committed certificate JSON; each file also
restates its bound as the generated-constant-free Turán-density theorem
`<Name>_turanDensity`:

| Bound proved | Lean theorem | File | Checked by |
|---|---|---|---|
| `K₃`-free: edge density ≤ 1/2 (Mantel) | `Mantel_flagAlgebra` | [`Flagmatic/Mantel.lean`](LeanFlagAlgebras/Flagmatic/Mantel.lean) | `decide +kernel` |
| `K₃`-free: `P₃` density ≤ 3/4 | `K3freeP3_flagAlgebra` | [`Flagmatic/K3freeP3.lean`](LeanFlagAlgebras/Flagmatic/K3freeP3.lean) | `decide +kernel` |
| `K₃`-free: `C₄` density ≤ 3/8 | `K3freeC4_flagAlgebra` | [`Flagmatic/K3freeC4.lean`](LeanFlagAlgebras/Flagmatic/K3freeC4.lean) | `decide +kernel` |
| `K₄`-free: edge density ≤ 2/3 | `K4freeEdge_flagAlgebra` | [`Flagmatic/K4freeEdge.lean`](LeanFlagAlgebras/Flagmatic/K4freeEdge.lean) | `decide +kernel` |
| `K₃`-free: `C₅` density ≤ 24/625 (Erdős pentagon) | `ErdosPentagon_flagAlgebra` | [`Flagmatic/ErdosPentagon.lean`](LeanFlagAlgebras/Flagmatic/ErdosPentagon.lean) | `decide +kernel` |
| `K₅`-free: edge density ≤ 3/4 | `K5freeEdge_flagAlgebra` | [`Flagmatic/K5freeEdge.lean`](LeanFlagAlgebras/Flagmatic/K5freeEdge.lean) | `native_decide` |
| `C₅`-free: edge density ≤ 1/2 | `C5freeEdge_flagAlgebra` | [`Flagmatic/C5freeEdge.lean`](LeanFlagAlgebras/Flagmatic/C5freeEdge.lean) | `native_decide` |

The certificate argument gives the upper-bound direction; hand-developed
lower bounds complete two Turán densities:

| Result | Lean theorem | File |
|---|---|---|
| Mantel's theorem: `turanDensity K₃ = 1/2` | `Mantel_Turan` | [`MantelTheorem/MantelTheorem.lean`](LeanFlagAlgebras/MantelTheorem/MantelTheorem.lean) |
| Erdős pentagon: `generalizedTuranDensity K₃ C₅ = 24/625` | `ErdosPentagon_Turan` | [`ErdosPentagon/ErdosPentagon.lean`](LeanFlagAlgebras/ErdosPentagon/ErdosPentagon.lean) |

Headline results of the meta-theory (the full paper-to-Lean correspondence
tables are in the [MetaTheory README](LeanFlagAlgebras/MetaTheory/README.md)):

| Result | Lean theorem | File |
|---|---|---|
| Every blow-up-closed hereditary class is root-plantable | `blowupClosed_root_plantable` | [`MetaTheory/BlowupClosed.lean`](LeanFlagAlgebras/MetaTheory/BlowupClosed.lean) |
| Clone-closed classes (e.g. `K_r`-free): quotient = ensemble semantics | `clone_root_plantable` | [`MetaTheory/CloneClosed.lean`](LeanFlagAlgebras/MetaTheory/CloneClosed.lean) |
| Relative (slice) Positivstellensatz | `relative_positivstellensatz` | [`MetaTheory/RelativePositivstellensatz.lean`](LeanFlagAlgebras/MetaTheory/RelativePositivstellensatz.lean) |
| The `C₅`-free class is not root-plantable at the edge type | `c5free_edge_not_rootPlantable` | [`MetaTheory/C5EdgeObstruction.lean`](LeanFlagAlgebras/MetaTheory/C5EdgeObstruction.lean) |

## What's here

| Area | Path | Description |
|------|------|-------------|
| **Flagmatic-to-Lean** (the main contribution) | [`LeanFlagAlgebras/Flagmatic`](LeanFlagAlgebras/Flagmatic/README.md) | The `flag_certificate` tactic compiles Flagmatic SDP certificates (JSON) into complete Lean proofs at elaboration time, with `flagmatic_to_lean.py` generating the surrounding source files; the seven committed certificates and the proof files generated from them ([details](LeanFlagAlgebras/Flagmatic/README.md)) |
| Tactics | `LeanFlagAlgebras/Automation` | The `flag_certificate` certificate-to-proof elaborator (`FlagCertificate.lean`), flag expansion / multiplication / sum-normalisation tactics, and exact-rational `LDLᵀ` PSD checking — the tactic layer the generated proofs run on |
| Core library | `LeanFlagAlgebras/{FlagAlgebra,Flags,Forbid,GraphAlgebra,Turan}` | Flags, flag algebras, densities, forbidden-subgraph classes, Turán densities |
| Meta-theory | [`LeanFlagAlgebras/MetaTheory`](LeanFlagAlgebras/MetaTheory/README.md) | Completeness of forbidden-subgraph reasoning in flag algebras; graphon limits, blow-ups, root-planting, and a relative Positivstellensatz ([details](LeanFlagAlgebras/MetaTheory/README.md)). Self-contained paper source: [`MetaTheory/paper.tex`](LeanFlagAlgebras/MetaTheory/paper.tex) |
| Worked results | `LeanFlagAlgebras/{MantelTheorem,ErdosPentagon}` | Hand-developed proofs of headline results, including the lower bounds above |

## Verification status

- **Sorry-free and axiom-free.** The library contains no `sorry` or `admit`
  and declares no `axiom`s; every proof is elaborated and checked by the Lean
  kernel. The root module
  [`LeanFlagAlgebras.lean`](LeanFlagAlgebras.lean) imports the entire
  library, so `lake build` re-verifies everything.
- **Axioms.** Five of the seven certificate case studies are checked entirely
  by `decide +kernel`: `#print axioms` on their main theorems lists only
  Lean's three standard axioms (`propext`, `Classical.choice`, `Quot.sound`).
  The two largest cases (`K5freeEdge`, `C5freeEdge`) discharge their finite
  computations with `native_decide` and therefore additionally trust Lean's
  compiler and runtime (`Lean.ofReduceBool`, `Lean.trustCompiler`).
- **Trusted base.** Neither the SDP solver nor the compiler frontends (the
  `flag_certificate` metaprogram and the scaffolding script) are trusted for
  soundness: every claim is carried by a proof term Lean checks. The anchor
  for *translation fidelity* is the theorem statement fixed in the source
  file — the tactic can only close the goal that statement poses, so a
  mistranscribed target, forbidden graph, or bound surfaces as an
  elaboration failure. What remains to audit is the statement itself, by
  reading it in the source file.
- The meta-theory layer keeps its own per-theorem audit: see the MetaTheory
  README sections
  [Status & verification](LeanFlagAlgebras/MetaTheory/README.md#status--verification)
  and [Axioms assumed](LeanFlagAlgebras/MetaTheory/README.md#axioms-assumed).

## Building

Checking the proofs requires only Lean. The Lean toolchain is pinned in
[`lean-toolchain`](lean-toolchain) (installed automatically by
[`elan`](https://github.com/leanprover/elan)); the Mathlib version is pinned
in [`lake-manifest.json`](lake-manifest.json). All SDP certificates and the
Lean proofs generated from them are checked in, so no Python, Flagmatic, or
SDP solver is needed to verify any theorem.

```bash
# fetch the prebuilt Mathlib cache (recommended — avoids recompiling Mathlib)
lake exe cache get

# build (and thereby re-verify) the whole library
lake build

# or build a single module and its dependencies (much faster)
lake build LeanFlagAlgebras.Flagmatic.Mantel
```

A full build is heavy (several thousand compilation jobs; some certificate
proofs use `native_decide`), so building individual modules is often more
convenient.

### Regenerating the generated proofs (optional)

The proof files in `LeanFlagAlgebras/Flagmatic/*.lean` are generated from the
certificates in
[`Flagmatic/Certificates/`](LeanFlagAlgebras/Flagmatic/Certificates) by

```bash
python LeanFlagAlgebras/Flagmatic/flagmatic_to_lean.py gen-skeleton \
    LeanFlagAlgebras/Flagmatic/Certificates/Mantel_cert.json \
    LeanFlagAlgebras/Flagmatic/Mantel.lean --namespace Mantel --force
```

The emitted file proves its main theorem by `flag_certificate`, which reads
the certificate JSON at elaboration time; passing `--materialize` emits the
fully expanded legacy form instead (inline matrices and tactic proof, no
build-time certificate dependence), and `--native-decide` switches the
file's finite computations to `native_decide` (used for the two largest
cases). This needs only Python 3 (standard library). Producing *new* SDP
certificates additionally requires
[Flagmatic](https://github.com/jsliacan/flagmatic), which runs under
[SageMath](https://www.sagemath.org/); the seven committed certificates are
Flagmatic's output as produced. See the
[Flagmatic README](LeanFlagAlgebras/Flagmatic/README.md) for the full
workflow.

## API documentation

API docs are generated with [doc-gen4](https://github.com/leanprover/doc-gen4)
via the `docbuild/` setup:

```bash
cd docbuild
MATHLIB_NO_CACHE_ON_UPDATE=1 lake update LeanFlagAlgebras
MATHLIB_NO_CACHE_ON_UPDATE=1 lake build LeanFlagAlgebras:docs
cd .lake/build/doc && python3 -m http.server   # then open http://127.0.0.1:8000/
```

A [leanblueprint](https://github.com/PatrickMassot/leanblueprint) dependency
graph (proof-of-concept) lives in [`blueprint/`](blueprint).

## Citation

<!-- Paper citation / arXiv link to be added before publication. -->

## License

This project is licensed under the [Apache License 2.0](LICENSE), the same
license as Lean 4 and Mathlib.
