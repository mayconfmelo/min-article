#!/usr/local/env bash
# USAGE: version [VERSION] [PROJECT-ROOT]

VERSION="$1"
PROJECT_ROOT="${2:-..}"

# Get package name from typst.toml
NAME=$(
  perl \
    -ne "print \$1 if /^\s*name\s*=\s*[\"']?(.*?)[\"']?\s*$/" \
    "${PROJECT_ROOT}/typst.toml"
)

if [[ ! "${VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Invalid version: ${VERSION}. Must be semantic"
fi

echo "Updating \"typst.toml\" to new version..."
perl -i -pe \
  's/^(\s*version\s*=\s*).*/$1"'${VERSION}'"/' \
  "${PROJECT_ROOT}/typst.toml"

echo "Adding new entry to \"CHANGELOG.md\"..."
sed -i "1s/^/# ${VERSION}\n\n/" "${PROJECT_ROOT}/CHANGELOG.md"

echo "Updating \"docs/example.typ\" to new version..."
sed -i \
  "s/${NAME}:[0-9]\+\.[0-9]\+\.[0-9]\+/${NAME}:${VERSION}/" \
  "${PROJECT_ROOT}/docs/assets/example.typ"
  
echo "Creating new git commit and tag..."
git add .
git commit -m "Package version ${VERSION} released"
git tag -a "${VERSION}" -m "Package version updated to ${VERSION}"
git push origin "${VERSION}"

echo "New version ${VERSION} released."
echo "Do not forget to document changes in the \"CHANGELOG.md\" file."
echo "Run \"just install\" to install it locally."