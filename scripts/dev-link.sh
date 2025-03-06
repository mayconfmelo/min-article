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

TARGET="local"
VERSION="0.0.0"

# Project root Directory
PROJECT_ROOT="${1:-$PWD}"
if [[ ! -d "${PROJECT_ROOT}" ]]; then
  echo "Directory not found: \"${PROJECT_ROOT}\""
fi

# Get package name from typst.toml
NAME=$(
  perl \
    -ne "print \$1 if /^\s*name\s*=\s*[\"']?(.*?)[\"']?\s*$/" \
    "${PROJECT_ROOT}/typst.toml"
)

# Set package directory
LINK_DIR="${DATA_DIR}/typst/packages/${TARGET}/${NAME}"

if [[ -d "${LINK_DIR}/${VERSION}" ]]; then
  echo "Deleting symlink: \"${LINK_DIR}/${VERSION}\""
  rm "${LINK_DIR}/${VERSION}" 2>/dev/null || true
  # Remove dev linked version in "typst.toml":
  perl -i -pe \
    's/^(\s*version\s*=\s*).*?#(.*)/$1$2/' \
    "${PROJECT_ROOT}/typst.toml"
  echo "Symlink removal finished"
else
  echo "Creating symlink: \"${LINK_DIR}/${VERSION}\""
  mkdir "${LINK_DIR}" 2>/dev/null || true
  ln -s "${PROJECT_ROOT}" "${LINK_DIR}/${VERSION}"
  # Comment original version and insert dev linked version in "typst.toml":
  perl -i -pe \
    's/^(\s*version\s*=\s*)(.*)/$1"0.0.0" #$2/' \
    "${PROJECT_ROOT}/typst.toml"
  echo "Symlink creation finished"
fi