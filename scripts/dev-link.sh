#!/usr/local/env bash
# DESC: Symlink Typst project in ../ to DATA-DIR/typst/package/local/
# USAGE: dev-link [PROJECT-ROOT]

# Find system data dir
if [[ "$OSTYPE" == "linux"* ]]; then
  DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  DATA_DIR="$HOME/Library/Application Support"
else
  DATA_DIR="${APPDATA}"
fi

VERSION="0.0.0"
PROJECT_ROOT="${1:-$PWD}"
DEL=${2-true}

if [[ -d "${PROJECT_ROOT}" ]]; then
  cd "${PROJECT_ROOT}"
else
  echo "Directory not found: \"${PROJECT_ROOT}\""
  exit 1
fi

# Get package name from typst.toml
NAME=$(
  perl \
    -ne "print \$1 if /^\s*name\s*=\s*[\"']?(.*?)[\"']?\s*$/" \
    typst.toml
)
# Set link directories
LOCAL_DIR="${DATA_DIR}/typst/packages/local/${NAME}"
PREVIEW_DIR="${DATA_DIR}/typst/packages/preview/${NAME}"
# List all Typst files
TYP_CODE=(
  $(find . -type f -iname "*.typ")
)

if [[ -d "${LOCAL_DIR}/${VERSION}" ]]; then
  # Disable deletion
  if [[ $DEL != true ]]; then
    exit 0
  fi
  
  echo "Deleting symlink for '${NAME}:${VERSION}'"
  rm "${LOCAL_DIR}/${VERSION}" 2>/dev/null || true
  rm "${PREVIEW_DIR}/${VERSION}" 2>/dev/null || true
  # Remove dev linked version in "typst.toml":
  perl -i -pe \
    's/^(\s*version\s*=\s*).*?#(.*)/$1$2/' \
    typst.toml
  # Get restored package version from typst.toml
  VERSION=$(
    perl \
      -ne "print \$1 if /^\s*version\s*=\s*[\"']?(.*?)[\"']?\s*$/" \
      typst.toml
  )
  echo "Symlink removal finished"
else
  echo "Creating symlink for \"${NAME}:${VERSION}\""
  mkdir -p "${LOCAL_DIR}" 2>/dev/null || true
  mkdir -p "${PREVIEW_DIR}" 2>/dev/null || true
  ln -s "${PROJECT_ROOT}" "${LOCAL_DIR}/${VERSION}"
  ln -s "${PROJECT_ROOT}" "${PREVIEW_DIR}/${VERSION}"
  # Comment original version and insert dev linked version in "typst.toml":
  perl -i -pe \
    's/^(\s*version\s*=\s*)(.*)/$1"0.0.0" #$2/' \
    typst.toml
  echo "Symlink creation finished"
fi

echo "Updating version number in Typst files..."
for file in ${TYP_CODE[@]}; do
  sed -i "s/${NAME}:[0-9.]\+/${NAME}:${VERSION}/" "${file}"
done