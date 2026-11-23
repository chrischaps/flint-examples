# CLAUDE.md

Guidance for agents working in this repository.

## What this is

Flint's curated examples: one scene each for a part of the engine, at this
repository's root, listed in `index.toml` (topic and purpose). They moved out
of the engine's tree in Flint #984 (ADR 0131 there), so a game's `engine/`
stops carrying them. The engine is a squashed git subtree at `engine/`
(Flint's `main`); this repo is a Flint project like any game, so the
engine's own docs apply: `engine/CLAUDE.md` (commands, the asset search,
gotchas) and the scoped CLAUDE.md files it points to, the script API in
`engine/docs/book/`.

## Commands

The binaries are the engine's, built once with
`cargo build --release --manifest-path engine/Cargo.toml` (several GB under
`engine/target/`; check free disk first). Run everything from this root,
where `flint.toml` names the schemas, so no command needs `--schemas`:

```bash
F=engine/target/release
$F/flint examples --check                    # what CI runs: indexed, and each validates
$F/flint check <scene>                       # every problem of one scene, scripts included
$F/flint play phase4_runtime.scene.toml
$F/flint render pbr_test.scene.toml --no-grid -o renders/pbr.png
$F/flint capture film/film.toml --shot 02_type --scale 0.5   # the film rig
```

A path in a scene is relative to the scene; a path a script names
(`load_scene("showcase_crucible.scene.toml")`, `load_ui("ui/pause.ui.toml")`,
a music manifest's stems) is from this root.

## Rules

- **Never edit `engine/`.** It is Flint's tree; changes go to Flint as a PR
  or an issue (https://github.com/chrischaps/Flint), then come here with
  `git subtree pull --prefix=engine flint-engine main --squash` (the
  `flint-engine` remote is `https://github.com/chrischaps/Flint.git`).
  After a pull: `flint examples --check`, and play the examples the pull
  touched.
- **An engine feature with an example bench is two PRs**: Flint's first
  (with its tests on Flint's own fixtures), then one here that pulls the
  merged engine and adds or changes the bench.
- **Every scene has an entry in `index.toml`**; `flint examples --check`
  fails a scene on disk with none, an entry with no file, or a scene that
  fails `flint validate`.
- **Nothing pins the examples' pixels.** Flint's goldens load frozen copies in
  its `tests/fixtures/scenes/`; improve an example freely. A scene only a test
  needs goes there, in Flint, not here.
- Flint's book and notes cite an example as `flint-examples/<path>`, and
  Flint's docs-check holds every such path to a file here: renaming or
  deleting one breaks Flint's CI until its citations follow. Search Flint
  for the old path first.
- Commit and push only when asked.
