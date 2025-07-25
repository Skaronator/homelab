#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DOCS_DIR="$SCRIPT_DIR/../docs"
PORT="8000"

VERSION=$(sed -n 's/mkdocs-material==\(.*\)/\1/p' "$DOCS_DIR/requirements.txt")
IMAGE="ghcr.io/squidfunk/mkdocs-material:$VERSION"

docker run --rm -it --entrypoint="" -p "$PORT:$PORT" -v "$DOCS_DIR":/docs \
  "$IMAGE" sh -c "pip install -r requirements.txt && mkdocs serve --dev-addr=0.0.0.0:$PORT"
