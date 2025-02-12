#!/usr/local/env bash
# USAGE: package [ACTION] [TARGET] [PROJECT-ROOT]

# Find system data dir
if [[ "$OSTYPE" == "linux"* ]]; then
  DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  DATA_DIR="$HOME/Library/Application Support"
else
  DATA_DIR="${APPDATA}"
fi

# Check invalid target package path;
case "$2" in
  "local"|"preview")
    TARGET="$2"
    ;;
  "")
    TARGET="local"
    ;;
  *)
    echo "Invalid target: \"$1\""
    echo "USAGE: $0 [ACTION] [TARGET] [PROJECT-ROOT]"
    exit 1
    ;;
esac

# Project root Directory
PROJECT_ROOT="${3:-..}"
if [[ ! -d "${PROJECT_ROOT}" ]]; then
  echo "Directory not found: \"${PROJECT_ROOT}\""
fi

# Get package name from typst.toml
NAME=$(
  perl \
    -ne "print \$1 if /^\s*name\s*=\s*[\"']?(.*?)[\"']?\s*$/" \
    "${PROJECT_ROOT}/typst.toml"
)
VERSION=$(
  perl \
    -ne "print \$1 if /^\s*version\s*=\s*[\"']?([^\"]*)[\"']?.*/g" \
    "${PROJECT_ROOT}/typst.toml"
)

ACTION="$1"

# Check if package is installed. If not, set to install it:
if [[ "${ACTION}" == "check" ]]; then
  if [[ -d "${DATA_DIR}/typst/packages/local/${NAME}" ]]; then
    echo "Package \"${NAME}\" installed in \"local\""
    exit 0
  elif [[ -d "${DATA_DIR}/typst/packages/preview/${NAME}" ]]; then
    echo "Package \"${NAME}\" installed in \"preview\"."
    exit 0
  else
    echo  "Package \"${NAME}\" not installed. Preparing to install..."
    ACTION="install"
  fi
fi

# Check if version is set to "0.0.0" because of dev-link"
if [[ "${VERSION}" == "0.0.0" ]]; then
  echo "Development link activated. Aborting..."
  echo "Run \"dev-link\" to deactivate it."
  exit 1
fi

# Set package directory
LIB_DIR="${DATA_DIR}/typst/packages/${TARGET}/${NAME}"
# Install or remove package:
case "${ACTION}" in
  "install")
    echo "Installing package to: \"${LIB_DIR}/${VERSION}\""
    mkdir -p "${LIB_DIR}"
    rm -r "${LIB_DIR}/${VERSION}"
    # Copy all package files to its path:
    cp -r "${PROJECT_ROOT}" "${LIB_DIR}/${VERSION}"
    if [[ $? == 0 ]]; then
      echo "Package files successfully copied."
    else
      echo "Could not copy package files. Aborting..."
      exit 
    fi
    
    # Find files and directories excluded from tje final package:
    EXCLUDES=()
    IFS=$'\n'
    while read -r linha; do
        EXCLUDES+=("$linha")
    done < <(
      perl -00 -ne \
        'if (/\s*exclude\s*=\s*\[(.*?)\]/s) {
          my @values = $1 =~ /"([^"]+)"/g;
          print "$_\n" for @values
        }' \
        "${PROJECT_ROOT}/typst.toml"
    )
    
    # Remove files and directories excluded in typst.toml:
    if [[ ${#EXCLUDES[@]} -ne 0 ]]; then
      echo "Removing excluded files from final package."
      cd "${LIB_DIR}/${VERSION}"

      for EXCLUDE in ${EXCLUDES[@]}; do
        if [[ -e "${EXCLUDE}" ]]; then
          rm -r "${EXCLUDE}"
          echo "File or directory removed: ${EXCLUDE}"
        else
          echo "File or directory does not exist: ${EXCLUDE}"
        fi
      done
    fi
    echo "Package \"${NAME}\" installed in \"${TARGET}\"."
    ;;
    
  "remove")
    echo "Removing package in: \"${LIB_DIR}\""
    # Remove package directory:
    rm -r "${LIB_DIR}"
    if [[ $? == 0 ]]; then
      echo "Package \"${NAME}\" removed from \"${TARGET}\"."
    else
      echo "Package  \"${NAME}\" not found in \"${TARGET}\""
    fi
    ;;
    
  *)
    echo "Invalid action: \"${ACTION}\""
    echo "USAGE: $0 [ACTION] [TARGET] [PROJECT-ROOT]"
    exit 1
    ;;
esac
