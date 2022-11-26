#!/usr/bin/env bash

CurrentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$CurrentDir/build.sh"
bash "$CurrentDir/build/misskey.sh" "$@"
