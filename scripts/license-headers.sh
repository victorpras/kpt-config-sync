#!/bin/bash
# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euo pipefail

if [ "${GOBIN:-"unset"}" == "unset" ]; then
  echo "GOBIN unset"
  exit 1
fi

ignores=(
  "-ignore=vendor/**"
  "-ignore=e2e/testdata/helm-charts/**"
  "-ignore=.output/**"
  "-ignore=e2e/testdata/*.xml"
  "-ignore=.idea/**"
  "-ignore=.vscode/**"
)

case "$1" in
  lint)
    "${GOBIN}/addlicense" -check "${ignores[@]}" . 2>&1 | sed '/ skipping: / d'
    ;;
  add)
    "${GOBIN}/addlicense" -v -c "Google LLC" -f LICENSE_TEMPLATE \
      "${ignores[@]}" \
      . 2>&1 | sed '/ skipping: / d'
    ;;
  *)
    echo "Usage: $0 (lint|add)"
    exit 1
    ;;
esac
