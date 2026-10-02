# `LeanFlagAlgebras/Flagmatic/` - Flagmatic certificate to Lean automation

This directory is the **main contribution of the accompanying paper**: the
tools that **turn Flagmatic SDP certificates into Lean 4 flag-algebra proofs
automatically**, together with the generated proof artifacts — the seven case
studies evaluated in the paper (Section 5.4).

```
Flagmatic/
├── flagmatic_to_lean.py   ← certificate-to-proof compiler (parser/generator/CLI)
├── flag_enumeration.py    ← canonical typed-flag enumeration (in-memory)
├── graph_enumeration.py   ← canonical graph enumeration (in-memory)
├── Certificates/          ← input: sparse SDP JSON exported by Flagmatic
└── *.lean                 ← output: proof files generated from the certificates
```

---

## Requirements

- **Checking the committed proofs**: nothing beyond the repository's pinned
  Lean toolchain — the certificates (`Certificates/*.json`) and the proof
  files generated from them (`*.lean`) are both checked in, and `lake build`
  re-verifies everything.
- **Running `flagmatic_to_lean.py`**: Python 3, standard library only.
- **Producing new SDP certificates**:
  [Flagmatic](https://github.com/jsliacan/flagmatic), which runs under
  [SageMath](https://www.sagemath.org/). The seven committed certificates are
  Flagmatic's output as produced.

---

## The `flag_certificate` tactic

The compiler runs **inside Lean's elaborator**, exposed as the
`flag_certificate` tactic
([`Automation/FlagCertificate.lean`](../Automation/FlagCertificate.lean)).
A source file states the desired bound and proves it by naming the
certificate file and the forbidden graph:

```lean
theorem Mantel_flagAlgebra
    : FlagAlgebra_2_0_0_1 ≤[completeGraph (Fin 3)] (1 / 2 : ℝ) • (1 : FlagAlgebra ∅ₜ)
  := by
  flag_certificate "LeanFlagAlgebras/Flagmatic/Certificates/Mantel_cert.json" K3
```

The certificate is *candidate data only*, read at elaboration time: the
tactic matches its flags against Lean's own canonical enumeration,
reconstructs each SDP block matrix `M = R·Q'·Rᵀ` together with an exact
rational `LDLᵀ` witness (re-checked in Lean by `psd_real_ldlt_terms`), and
synthesizes the complete proof of exactly the stated theorem — a
statement/certificate mismatch fails elaboration instead of proving an
unintended theorem. The variant `flag_certificate?` additionally offers the
synthesized script as a one-click `Try this:` suggestion, so the explicit
proof (inline matrices, PSD checks, closing normalization) can be
materialized, audited, and checked independently of the certificate file.

One caveat of the elaboration-time design: the certificate is a build-time
input that `lake` does not track, so editing a certificate does not by
itself trigger rechecking of the Lean file that reads it.

---

## One-line automation

```powershell
python LeanFlagAlgebras/Flagmatic/flagmatic_to_lean.py gen-skeleton `
    LeanFlagAlgebras/Flagmatic/Certificates/<Name>_cert.json `
    LeanFlagAlgebras/Flagmatic/<Name>.lean `
    --namespace <Name> --force
```

This single command writes the scaffolding around that theorem: imports,
opens, namespace declarations, the `generate_forbid_free_*` commands, the
main theorem `<Name>_flagAlgebra` proved by `flag_certificate`, and a
Turán-density restatement `<Name>_turanDensity` (via
`generalizedTuranDensity_le_of_forbidLE`) whose statement mentions no
generated constant. Evaluation mode: `decide +kernel` by default.
`--mask-density` routes the pair densities through the bit-mask kernel
routes of `LeanFlagAlgebras/BitMask`, and `--mask-flagsets` does the same for
the flag lists of a non-clique forbidden graph; `K5freeEdge` uses the first,
`C5freeEdge` both, and each file's header records its exact regeneration
command. `--native-decide` switches the generated file to `native_decide`;
no committed case uses it.
Passing `--materialize` instead emits the fully expanded legacy form, in
which the matrices, PSD proofs, and the complete tactic proof appear in the
source file itself and the certificate is not read at build time.

For other subcommands, run `python flagmatic_to_lean.py --help` or check the
docstring at the top of `flagmatic_to_lean.py`.

---

## The seven paper cases (Section 5.4)

| File | Forbid `H` | Target `F` | `N` | Blocks | Bound | Checked by |
|---|---|---|---|---|---|---|
| `Mantel.lean` | K₃ | edge | 3 | 1 | `1/2` | `decide +kernel` |
| `K3freeP3.lean` | K₃ | P₃ | 3 | 1 | `3/4` | `decide +kernel` |
| `K3freeC4.lean` | K₃ | C₄ | 4 | 2 | `3/8` | `decide +kernel` |
| `K4freeEdge.lean` | K₄ | edge | 4 | 2 | `2/3` | `decide +kernel` |
| `ErdosPentagon.lean` | K₃ | C₅ | 5 | 3 | `24/625` | `decide +kernel` |
| `K5freeEdge.lean` | K₅ | edge | 5 | 4 | `3/4` | `decide +kernel` (bit-mask route) |
| `C5freeEdge.lean` | C₅ | edge | 5 | 4 | `1/2` | `decide +kernel` (bit-mask route) |

File and theorem names follow the paper's case table: `<H>free<Target>`, with
the two named cases (`Mantel`, `ErdosPentagon`) kept under their proper names.
Each file proves `<cert-stem>_flagAlgebra` by `flag_certificate` and restates
it as `<cert-stem>_turanDensity`, the generalized Turán-density bound whose
statement mentions no generated constant.

---

## Workflow for a new certificate

```powershell
# 1. Optional: mapping sanity check (also validates the cert — every flagmatic
#    string is resolved to a canonical Lean identifier, raising on any failure).
python LeanFlagAlgebras/Flagmatic/flagmatic_to_lean.py inspect <cert>.json

# 2. Generate the Lean file (flags, densities and products are all generated
#    inside Lean by the `generate_forbid_free_*` commands — no JSON files on disk).
python LeanFlagAlgebras/Flagmatic/flagmatic_to_lean.py gen-skeleton `
    LeanFlagAlgebras/Flagmatic/Certificates/<Name>_cert.json `
    LeanFlagAlgebras/Flagmatic/<Name>.lean --namespace <Name> --force

# 3. Build
lake build LeanFlagAlgebras.Flagmatic.<Name>

# 4. Optional: add the import to the root manifest LeanFlagAlgebras.lean
```

---

## Forbidden graphs

The forbidden graph is read from the certificate's `forbid` clause and emitted
as a `Sym2Graph` **term**: a complete graph `K_r` becomes `completeSym2Graph r`,
any other graph an explicit edge set. Both feed the same
`generate_forbid_free_*` commands, which forbid the graph as a (non-induced)
subgraph and dispatch internally — a complete forbid takes the pruned clique
route, any other the subgraph route. No per-graph registration is needed.

---

## Flagmatic certificate format (reference)

```json
{
  "description": "2-graph; maximize <objective_str> density; forbid <forbid_str>",
  "bound": "1/2",
  "order_of_admissible_graphs": 3,
  "number_of_admissible_graphs": 3,
  "admissible_graphs": ["3:", "3:12", "3:1213"],
  "number_of_types": 1,
  "types": ["1:"],
  "numbers_of_flags": [2],
  "flags": [["2:(1)", "2:12(1)"]],
  "qdash_matrices": [[[2]]],
  "r_matrices": [[["1/2"], ["-1/2"]]],
  "admissible_graph_densities": [0, "1/3", "2/3"]
}
```

### Flagmatic string encoding

- Vertices are 1-indexed and written as single digits when possible (vertex ≤ 9).
- Edges are encoded as two-digit pairs. For example, `"4:121324"` means vertex 4 with edges {1-2, 1-3, 2-4}.
- Sigma-flag labels use the form `"3:12(2)"`, meaning 3 vertices with the first 2 as type vertices (labels 0 and 1).

### How the automation uses the certificate

| Lean output | Source |
|---|---|
| Objective identifier (e.g. `FlagAlgebra_2_0_0_1`) | `description`'s `maximize ...` clause, resolved by graph isomorphism |
| Forbidden graph term (`completeSym2Graph r` or an explicit `Sym2Graph` edge set) | `description`'s `forbid ...` clause |
| Bound (e.g. `(1 / 2 : ℝ)`) | `cert["bound"]` |
| Host size N | `cert["order_of_admissible_graphs"]` |
| σ_t, v_t | `cert["types"]`, `cert["flags"]` |
| M_t matrix | `R_t · Q'_t · R_tᵀ` (`qdash` stores the upper-triangular rows) |
| LDLᵀ decomposition | Exact rational LDL decomposition computed from `M_t` |
| Objective-expansion auxiliary lemma (targets below the host size) | Exhaustive computation of induced densities over all vertex subsets of the host graph |
