#!/usr/bin/env bash

set -e

JSON_MODE=false
ARGS=()
for arg in "$@"; do
    case "$arg" in
        --json) JSON_MODE=true ;;
        --help|-h) echo "Usage: $0 [--json] <description>"; exit 0 ;;
        *) ARGS+=("$arg") ;;
    esac
done

DESCRIPTION="${ARGS[*]}"

if [ -z "$DESCRIPTION" ]; then
    echo "Usage: $0 [--json] <description>" >&2
    exit 1
fi

find_repo_root() {
    local dir="$1"
    while [ "$dir" != "/" ]; do
        if [ -d "$dir/.git" ] || [ -d "$dir/.specify" ]; then
            echo "$dir"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    return 1
}

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if git rev-parse --show-toplevel >/dev/null 2>&1; then
    REPO_ROOT=$(git rev-parse --show-toplevel)
    HAS_GIT=true
else
    REPO_ROOT="$(find_repo_root "$SCRIPT_DIR")"
    if [ -z "$REPO_ROOT" ]; then
        echo "Error: Could not determine repository root" >&2
        exit 1
    fi
    HAS_GIT=false
fi

cd "$REPO_ROOT"

SPECS_DIR="$REPO_ROOT/specs"
mkdir -p "$SPECS_DIR"

HIGHEST=0
if [ -d "$SPECS_DIR" ]; then
    for dir in "$SPECS_DIR"/product-intake-*; do
        [ -d "$dir" ] || continue
        dirname=$(basename "$dir")
        number=$(echo "$dirname" | sed 's/product-intake-//' | grep -o '^[0-9]\+' || echo "0")
        number=$((10#$number))
        if [ "$number" -gt "$HIGHEST" ]; then HIGHEST=$number; fi
    done
fi

NEXT=$((HIGHEST + 1))
WORKFLOW_NUM=$(printf "%03d" "$NEXT")

BRANCH_SUFFIX=$(echo "$DESCRIPTION" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-//' | sed 's/-$//')
WORDS=$(echo "$BRANCH_SUFFIX" | tr '-' '\n' | grep -v '^$' | head -3 | tr '\n' '-' | sed 's/-$//')
if [ -z "$WORDS" ]; then
    WORDS="intake"
fi
BRANCH_NAME="product-intake/${WORKFLOW_NUM}-${WORDS}"
WORKFLOW_ID="product-intake-${WORKFLOW_NUM}"

if [ "$HAS_GIT" = true ]; then
    git checkout -b "$BRANCH_NAME"
else
    >&2 echo "[product-intake] Warning: Git not detected; skipped branch creation"
fi

WORKFLOW_DIR="$SPECS_DIR/${WORKFLOW_ID}-${WORDS}"
mkdir -p "$WORKFLOW_DIR"

TEMPLATE="$REPO_ROOT/.specify/extensions/workflows/product-intake/template.md"
TASKS_TEMPLATE="$REPO_ROOT/.specify/extensions/workflows/product-intake/tasks-template.md"

TEMPLATE_FILE="$WORKFLOW_DIR/template.md"
TASKS_FILE="$WORKFLOW_DIR/tasks.md"

if [ -f "$TEMPLATE" ]; then
    cp "$TEMPLATE" "$TEMPLATE_FILE"
else
    echo "# Product Intake" > "$TEMPLATE_FILE"
fi

if [ -f "$TASKS_TEMPLATE" ]; then
    cp "$TASKS_TEMPLATE" "$TASKS_FILE"
else
    echo "# Tasks" > "$TASKS_FILE"
fi

if [ -f "$TEMPLATE_FILE" ]; then
    sed -i.bak "s/product-intake-###/${WORKFLOW_ID}/g" "$TEMPLATE_FILE" 2>/dev/null || \
    sed -i '' "s/product-intake-###/${WORKFLOW_ID}/g" "$TEMPLATE_FILE" 2>/dev/null || true
    sed -i.bak "s|product-intake/###-description|${BRANCH_NAME}|g" "$TEMPLATE_FILE" 2>/dev/null || \
    sed -i '' "s|product-intake/###-description|${BRANCH_NAME}|g" "$TEMPLATE_FILE" 2>/dev/null || true
    rm -f "$TEMPLATE_FILE.bak"
fi

if [ -f "$TASKS_FILE" ]; then
    sed -i.bak "s/product-intake-###/${WORKFLOW_ID}/g" "$TASKS_FILE" 2>/dev/null || \
    sed -i '' "s/product-intake-###/${WORKFLOW_ID}/g" "$TASKS_FILE" 2>/dev/null || true
    rm -f "$TASKS_FILE.bak"
fi

export SPECIFY_WORKFLOW="$WORKFLOW_ID"

if $JSON_MODE; then
    printf '{"WORKFLOW_ID":"%s","BRANCH_NAME":"%s","TEMPLATE_FILE":"%s","TASKS_FILE":"%s","WORKFLOW_NUM":"%s"}\n' \
        "$WORKFLOW_ID" "$BRANCH_NAME" "$TEMPLATE_FILE" "$TASKS_FILE" "$WORKFLOW_NUM"
else
    echo "WORKFLOW_ID: $WORKFLOW_ID"
    echo "BRANCH_NAME: $BRANCH_NAME"
    echo "TEMPLATE_FILE: $TEMPLATE_FILE"
    echo "TASKS_FILE: $TASKS_FILE"
    echo "WORKFLOW_NUM: $WORKFLOW_NUM"
    echo ""
    echo "✅ Product intake workflow initialized"
fi
