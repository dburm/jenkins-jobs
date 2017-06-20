#!/bin/bash
set -ex

ARGS="-e SC2013"
if [ "${GERRIT_REFSPEC}" = "refs/heads/master" ]; then
  find "${WORKSPACE}" -name "*.sh" -type f -print0 | xargs -0 shellcheck "${ARGS}"
else
  # shellcheck disable=SC2086
  git diff HEAD~1 --name-only --diff-filter=AM | grep ".sh$" | xargs --no-run-if-empty shellcheck ${ARGS}
fi
