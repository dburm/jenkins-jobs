#!/bin/bash -e

# source this file, then run manage-projects -d -vv
# requires https://review.openstack.org/284843

wrkDir=$(pwd)


gerritHost=localhost
gerritPort=29418
gerritUrl=http://${gerritHost}:8081

gerritUser=infra-jeepyb
gerritKey=${wrkDir}/.ssh/jeepyb.rsa

gerritEmail=jeepyb@localhost.local
gerritCommitter="Infra Jeepyb <${gerritEmail}>"

aclDir=${wrkDir}/acls
projectsYaml=${wrkDir}/projects.yaml

gitDir=${wrkDir}/git
cacheDir=${wrkDir}/.cache
systemUser=${USER}
systemGroup=${USER}


export PROJECTS_YAML=${projectsYaml}
export PROJECTS_INI=${wrkDir}/projects.ini
export GIT_COMMITTER_EMAIL=$gerritEmail
export GIT_SSH="ssh -l ${gerritUser} -i ${gerritKey}"

cat > ${PROJECTS_INI} <<EOF
[projects]
homepage=${gerritUrl}
local-git-dir=${gitDir}
gerrit-host=${gerritHost}
gerrit-port=${gerritPort}
gerrit-user=${gerritUser}
gerrit-committer=${gerritCommitter}

gerrit-key=${gerritKey}
acl-dir=${aclDir}
jeepyb-cache-dir=${cacheDir}

has-github=False
has-wiki=False
has-issues=False
has-pull-requests=False
has-downloads=False

gerrit-system-user=${systemUser}
gerrit-system-group=${systemGroup}
gerrit-replicate=False
jeepyb-run-local=False
EOF
