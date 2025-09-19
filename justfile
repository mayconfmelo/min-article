root := justfile_directory()
name := `grep '^name' typst.toml | cut -d'"' -f2`
version := `grep '^version' typst.toml | cut -d'"' -f2`

[private]
default:
	@just --list --unsorted

# install package.
install target="preview":
  bash scripts/package.sh install "{{target}}" "{{root}}"
  
# remove package.
remove target="preview":
  bash scripts/package.sh remove "{{target}}" "{{root}}"
  
# run package tests.
test which="":
  tt run {{which}}
  
# compile the example file.
example:
  rm -r dev/example/ 2>/dev/null || true
  mkdir -p dev/example/
  typst compile template/main.typ dev/example/page-{0p}.png
  typst compile template/main.typ dev/example/doc.pdf
  #typst compile template/main.typ dev/example/doc.html --features html

# compile the manual.
doc:
  rm -r dev/manual/ 2>/dev/null || true
  mkdir -p dev/manual/
  typst compile manual.typ dev/manual/doc.pdf
  typst compile manual.typ dev/manual/page-{0p}.png

# remove all dev files.
clean:
  rm -r dev/manual/ 2>/dev/null || true
  rm -r dev/example/ 2>/dev/null || true
  rm -r dev/pkg/ 2>/dev/null || true
  rm -r dev/{{name}} 2>/dev/null || true
  tt util clean
  
# enables @local/0.0.0.
symlink:
  bash scripts/dev-link.sh "{{root}}"

# run spell check.
spell correct="no":
  #!/usr/bin/env bash
  arg=""
  if [[ {{correct}} != "no" ]]; then
    arg="--interactive 3 --write-changes"
  fi
  codespell $arg \
    --skip "*.pdf,dev/*,.git/*,./docs/assets/manual-pt.typ" \
    --ignore-words-list "ser,nomes,comando"

# init template in dev/
init:
  typst init '@preview/{{name}}:{{version}}' dev/{{name}}

# frequent dev commands.
[private]
dev:
  @just install preview
  @just example
  @just doc
  @just test
  
  
# release a new package version.
[private]
new version:
  @just example
  @just doc
  cp dev/example/doc.pdf docs/example.pdf
  cp dev/manual/doc.pdf docs/manual.pdf
  git tag
  bash scripts/version.sh "{{version}}" "{{root}}"
  
# install and build it (used in CI).
[private]
build:
  @just install preview
  @just example
  
# deploy to the Typst Universe repo in ../packages.
[private]
deploy:
  #!/usr/bin/env bash
  cd ../packages
  git checkout -b main
  just update
  git checkout -b {{name}}
  just delete {{name}} {{version}}
  just bring {{name}}
  git add . --sparse
  git status --short
  git commit -m "{{name}}:{{version}}"
  git push origin {{name}}
  git checkout main
  git branch -D {{name}}
  
# Update log files fir just recipes in dev/
[private]
log recipe:
  #!/usr/bin/env bash
  mkdir -p dev/
  date +"time: %Y-%m-%d (%H:%M)" >> dev/{{recipe}}.log
  just {{recipe}} 2> >(tee -a dev/{{recipe}}.log)
  echo "" >> dev/{{recipe}}.log
  echo "" >> dev/{{recipe}}.log