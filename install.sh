set -eu -o pipefail -o failglob
#version tools
export GCLOUD_VERSION=298.0.0
export PACKER_VERSION=1.6.0
export TERRAFORM_VERSION=0.12.28

#update and upgrade me
apk update && apk upgrade

# install python terraform and aws cli + dependancies
apk add sudo bash make unzip groff py-pip python3 py3-pip py3-yaml py3-s3transfer py3-rsa py3-jmespath py3-docutils py3-colorama py3-botocore aws-cli curl wget ruby-webrick

#install terraform and packer
wget -q -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip -q /tmp/terraform.zip -d /tmp && \
  chmod +x /tmp/terraform && \
  mv /tmp/terraform /usr/bin && \
  \
  wget -q -O /tmp/packer.zip https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip && \
  unzip -q /tmp/packer.zip -d /tmp && \
  chmod +x /tmp/packer && \
  mv /tmp/packer /usr/bin

#install ansible and dependancies
apk --update add python3-dev libffi-dev openssl-dev build-base
pip install --upgrade pip cffi && pip install ansible==2.9.10 ansible-lint

# install packages for ruby as inspec dependacy
apk add openssl openrc ruby ruby-doc ruby-bundler ruby-dev g++ libffi-dev musl-dev

# Install gems for inspec and dependancies
gem install --no-user-install bundler json method_source rake pry rainbow rspec rspec-its r-train rubyzip thor 'inspec:4.21.3' 'inspec-bin:4.21.3'

# install gcloud
wget -q -O /tmp/google-cloud-sdk.tgz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
tar xzf /tmp/google-cloud-sdk.tgz -C /usr/lib/
rm /tmp/google-cloud-sdk.tgz
ln -s /lib /lib64

#echo bin folder to path to install gcloud addons
export PATH=$PATH:/usr/lib/google-cloud-sdk/bin > /etc/environment

#install gcloud addons
gcloud config set core/disable_usage_reporting true && \
  gcloud config set component_manager/disable_update_check true && \
  gcloud config set metrics/environment github_docker_image && \
  gcloud components install kubectl docker-credential-gcr --quiet

#verify installs
ansible --version && \
  terraform version && \
  packer version && \
  gcloud version && \
  inspec version

# still to add gke-anthos binary
# clean up
rm -rf /tmp/*
