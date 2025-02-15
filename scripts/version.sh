#!/usr/local/env bash
# USAGE: version [VERSION] [PROJECT-ROOT]

VERSION="$1"
PROJECT_ROOT="${2:-..}"
NAME=$(
  perl \
    -ne "print \$1 if /^\s*name\s*=\s*[\"']?(.*?)[\"']?\s*$/" \
    "${PROJECT_ROOT}/typst.toml"
)

echo "Starting version update script. Did you already:"
echo "1. Added changes/new features to CHANGELOG.md"
echo "2. Updated README.md, if needed"
echo "3. Updated docs/manual.typ, if needed"
echo "Continue [y/N]?"
read ANSWER
case "${ANSWER}" in
  "Y"|"y"|"yes"|"YES"|"Yes")
    echo "Changing \"${NAME}\" to version \"${VERSION}\""
    ;;
    
  *)
    echo "Aborting..."
    exit 1
    ;;
esac

# Check if version is SemVer:
if [[ ! "${VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Invalid version: ${VERSION}."
  echo "Must be a semantic version"
  exit 1
fi

cd "${PROJECT_ROOT}"

SRC_CODE=(
  $(find . -type f -iname "*.typ")
)

echo "Updating version number in Typst files..."
for file in ${SRC_CODE[@]}; do
  sed -i "s/${NAME}:[0-9.]\+/${NAME}:${VERSION}/" "${file}"
done

echo "Updating version number in \"typst.toml\"..."
perl -i -pe 's/^(\s*version\s*=\s*).*/$1"'${VERSION}'"/' "typst.toml"

echo "Trying to commit unstaged changes, if any..."
git add .
git commit -m "Package version ${VERSION} released"
echo "Creating new git tag..."
git tag -a "${VERSION}" -m "Package version updated to ${VERSION}"
git push origin "${VERSION}"

echo "New version ${VERSION} successfully released."