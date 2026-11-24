# Flint examples

Curated scenes that each show what one part of
[Flint](https://github.com/chrischaps/Flint), the CLI-first game engine, does:
a tavern to walk through, a page that drifts and speaks, a world drawn in
type, trees that breathe, water on any mesh. Every one is a TOML scene with
its scripts and assets, listed in [`index.toml`](index.toml) with a topic and
a one-line purpose, and every frame is drawn live by the engine.

They lived in the engine's own tree until 2026-11 (Flint #984). A game
carries the engine whole as a subtree, so it carried these 45 MB too; here
they are a project like any game, and the engine's book links to them.

## Running them

The engine is carried as a squashed git subtree at `engine/`. Build it once
(a release build: a few minutes and a few GB under `engine/target/`):

```bash
cargo build --release --manifest-path engine/Cargo.toml
```

Then, from this folder:

```bash
F=engine/target/release
$F/flint examples                          # every example, by topic
$F/flint examples --topic stylize          # one topic
$F/flint play phase4_runtime.scene.toml    # the Phase 4 tavern (also: plain `flint play`)
$F/flint render pbr_test.scene.toml -o pbr.png
```

The scenes' own comments write these as `flint ...` and `flint-player ...`:
put `engine/target/release` on your PATH, or use a Flint checkout's
binaries, as long as they are built from the same engine.

**From a Flint checkout**, clone this repository into it (Flint's
`.gitignore` keeps it out), and every `flint-examples/<path>` in Flint's
book and notes is a path from the checkout's root:

```bash
cd Flint && git clone https://github.com/chrischaps/flint-examples
cargo run --bin flint -- play flint-examples/phase4_runtime.scene.toml
```

This project's `flint.toml` names the subtree's schemas, so a binary from a
newer engine reads the older schemas; pass
`--schemas schemas --schemas schemas/examples` from the checkout's root to
use its own.

## Taking an engine update

```bash
git remote add flint-engine https://github.com/chrischaps/Flint.git   # once
git subtree pull --prefix=engine flint-engine main --squash
cargo build --release --manifest-path engine/Cargo.toml
engine/target/release/flint examples --check
```

The squash hides the engine's commit subjects; `bash engine/scripts/changelog.sh since <day of the last pull>`
lists every change a project can notice since then.

## Adding or changing an example

Improve them freely. Nothing pins their pixels: the engine's render goldens
and CLI tests load frozen copies in Flint's `tests/fixtures/scenes/`, so a
change here never re-blesses a golden. A new scene needs an entry in
`index.toml`, and `flint examples --check` (what CI runs on every push and
PR) fails until it has one and passes `flint validate`. A scene only a test
needs belongs in Flint's fixtures instead.

An engine feature that comes with an example bench is two pull requests:
the engine's first, then one here that pulls the merged engine and adds the
bench.

The folders beside the scenes (`models/`, `textures/`, `scripts/`,
`particles/`, `styles/`, ...) are the examples' assets, found by the
engine's asset search (beside the scene, each folder above it up to this
root, then `engine/`). `film/` is the showcase film ("Many Hands"): its set, shot list,
storyboard, score and editor. `tools/` holds
the scripts that made some of the assets.

Whole films and places, made to be watched rather than to show one
feature, live in [flint-demos](https://github.com/chrischaps/flint-demos).
Engine bugs and wishes an example runs into go to
[Flint's issues](https://github.com/chrischaps/Flint/issues).

## Licences

Flint is MIT-licensed (its `Cargo.toml`), and the examples' own scenes and
scripts are offered on the same terms. Assets that came from elsewhere keep
their makers' terms: each font under `fonts/ofl/` is under the SIL Open Font
License (its `OFL.txt` beside it), and some of `models/` are public sample
models (Khronos' glTF samples among them).
