#!/bin/bash
# Copyright 2016 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail
CHECKPOINT_PATH="${CHECKPOINT_PATH:-/tmp/startup-script.kubernetes.io}"
CHECK_INTERVAL_SECONDS="30"
EXEC=(nsenter -t 1 -m -u -i -n -p --)
"${EXEC[@]}" rm -f "${CHECKPOINT_PATH}"

do_startup_script() {
  local err=0;
  echo "starting startup script execution"

  "${EXEC[@]}" bash -c "${STARTUP_SCRIPT}" && err=0 || err=$?
  if [[ ${err} != 0 ]]; then
    echo "startup-script failed! exit code '${err}'"
    return 1
  fi

  "${EXEC[@]}" touch "${CHECKPOINT_PATH}"
  echo "startup-script succeeded!"
  return 0
}

while :; do
  "${EXEC[@]}" stat "${CHECKPOINT_PATH}" && err=0 || err=$?
  if [[ ${err} != 0 ]]; then
    echo "Running startup script"
    do_startup_script
  fi

  echo "sleeping...."
  sleep "${CHECK_INTERVAL_SECONDS}"
done
