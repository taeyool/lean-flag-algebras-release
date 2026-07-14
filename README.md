# lean-flag-algebras

A [Lean 4](https://leanprover.org/) formalization of **flag algebras**
([Razborov, 2007](https://people.cs.uchicago.edu/~razborov/files/flag.pdf)),
together with a verified pipeline that turns semidefinite-programming
certificates into machine-checked extremal-combinatorics proofs.

This repository is the public artifact accompanying our paper on formalized
flag algebras. It contains the core library, the meta-theory of
forbidden-subgraph reasoning, the Flagmatic-to-Lean certificate-to-proof
compiler, and a collection of fully verified Turán-type results.

## What's here

| Area | Path | Description |
|------|------|-------------|
| Core library | `LeanFlagAlgebras/{FlagAlgebra,Flags,Forbid,GraphAlgebra,Turan}` | Flags, flag algebras, densities, forbidden-subgraph classes, Turán densities |
| Meta-theory | `LeanFlagAlgebras/MetaTheory` | Completeness of forbidden-subgraph reasoning in flag algebras; graphon limits, blow-ups, root-planting, and a relative Positivstellensatz. See [`MetaTheory/paper.tex`](LeanFlagAlgebras/MetaTheory/paper.tex). |
| Flagmatic-to-Lean | `LeanFlagAlgebras/Flagmatic` | `flagmatic_to_lean.py` compiles Flagmatic SDP certificates (JSON) into Lean proofs; generated proofs for Mantel, Turán `K4`/`K5`, the Erdős pentagon, `C5`, and several forbidden-subgraph bounds |
| Tactics | `LeanFlagAlgebras/Automation` | Flag expansion / multiplication / sum-normalisation tactics and a PSD-certificate proof generator |
| Worked results | `LeanFlagAlgebras/{MantelTheorem,ErdosPentagon,Logic}` | Additional hand-developed proofs of headline results |

The self-contained meta-theory paper source is included at
[`LeanFlagAlgebras/MetaTheory/paper.tex`](LeanFlagAlgebras/MetaTheory/paper.tex).

## Building

The Lean toolchain is pinned in [`lean-toolchain`](lean-toolchain) (installed
automatically by [`elan`](https://github.com/leanprover/elan)); the Mathlib
version is pinned in [`lake-manifest.json`](lake-manifest.json).

```bash
# fetch the prebuilt Mathlib cache (recommended — avoids recompiling Mathlib)
lake exe cache get

# build the whole library
lake build

# or build a single module and its dependencies (much faster)
lake build LeanFlagAlgebras.Flagmatic.MantelHfree
```

A full build is heavy (several thousand compilation jobs; some certificate
proofs use `native_decide`), so building individual modules is often more
convenient.

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

<!-- License to be added before publication (Apache-2.0 suggested, matching Mathlib). -->
