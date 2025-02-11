root := justfile_directory()

[private]
default:
	@just --list --unsorted
  
# Continuous compilaton
watch file="docs/assets/example.typ":
  bash scripts/package.sh check "local" "{{root}}"
  mkdir "dev" 2>/dev/null || true
  typst watch "{{file}}" "dev/output.pdf"
  
# Alias for watch
w file="docs/assets/example.typ":
  @just watch "{{file}}"

# One-time compilation
compile file="docs/assets/example.typ":
  bash scripts/package.sh check "local" "{{root}}"
  mkdir "dev" 2>/dev/null || true
  typst compile "{{file}}" "dev/output.pdf"
  
# Alias for compile
c file="docs/assets/example.typ":
  @just compile "{{file}}"
  
# Generate manual
manual:
  bash scripts/package.sh check "local" "{{root}}"
  mkdir "dev" 2>/dev/null || true
  typst compile "docs/manual.typ" "dev/manual.pdf"
  
# Generate manual in Brazilian Portuguese
manual-pt:
  bash scripts/package.sh check "local" "{{root}}"
  mkdir "dev" 2>/dev/null || true
  typst compile "docs/manual-pt.typ" "dev/manual-pt.pdf"


# Install package
install target="local":
  bash scripts/package.sh install "{{target}}" "{{root}}"
  
# Install package in both "local" and "preview" targets
install-all:
  bash scripts/package.sh install "local" "{{root}}"
  bash scripts/package.sh install "preview" "{{root}}"
  
# Remove package
remove target="local":
  bash scripts/package.sh remove "{{target}}" "{{root}}"

# Link package to installation path to development purposes (version 0.0.0)
dev-link:
  bash scripts/dev-link.sh "{{root}}"

# Release a new package version
version v:
  bash scripts/version.sh "{{v}}" "{{root}}"