#!/bin/bash

########################################################################################################################
# Get ClamAV DB
curl https://pivotal-clamav-mirror.s3.amazonaws.com/main.cvd     > /data/main.cvd
curl https://pivotal-clamav-mirror.s3.amazonaws.com/daily.cvd    > /data/daily.cvd
curl https://pivotal-clamav-mirror.s3.amazonaws.com/bytecode.cvd > /data/bytecode.cvd

########################################################################################################################
# Get Trivy DB

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

DB_VERSION=${DB_VERSION:-`get_latest_release aquasecurity/trivy-db`}

curl -L "https://github.com/aquasecurity/trivy-db/releases/download/${DB_VERSION}/trivy-offline.db.tgz" -o /data/trivy-offline.db.tar.gz

########################################################################################################################
# Clone Gemnasium DB
git clone https://gitlab.com/gitlab-org/security-products/gemnasium-db.git
