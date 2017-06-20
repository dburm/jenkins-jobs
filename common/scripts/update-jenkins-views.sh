#!/bin/bash
#
#   :mod:`update-jenkins-views` -- Updating jenkins views
#   =====================================================
#
#   .. module:: sample-bash-script
#       :platform: Unix, Windows
#       :synopsis: Update views on Jenkins envs
#
#
#   This script is used to update views on jenkins environments using
#   jenkins-view-builder and YAML files with view descriptions
#
#   .. envvar::
#       :var  CI_NAME: Id of Jenkins build under which this
#                      script is running, defaults to ``0``
#       :type CI_NAME: string
#       :var  VIEWS_LIST: Space separated list of view YAMLS to update.
#                         Will update all views if empty
#       :type VIEWS_LIST: string
#       :var  WORKSPACE: Location where build is started, defaults to ``.``
#       :type WORKSPACE: path
#
#
#   .. requirements::
#
#       * ``tox`` in ``/usr/bin/tox`
#

set -ex

tox -e ci-views

source ".tox/ci-views/bin/activate"

CONFIG_PATH="${WORKSPACE}/../tmp/${JOB_NAME}"

umask 0077
mkdir -p "${CONFIG_PATH}"
cat > "${CONFIG_PATH}/jenkins_jobs.ini" << EOF
[jenkins]
user=${JJB_USER}
password=${JJB_PASS}
url=${JENKINS_URL}
EOF

jenkins-jobs --conf "${CONFIG_PATH}/jenkins_jobs.ini" update "views/${CI_NAME}"
