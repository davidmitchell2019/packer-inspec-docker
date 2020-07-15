export GCLOUD_VERSION=298.0.0
apk update && apk upgrade
# install python terraform and aw cli
apk add groff python3 ansible py3-yaml py3-s3transfer py3-rsa py3-jmespath py3-docutils py3-colorama terraform py3-botocore aws-cli curl wget ruby-webrick
# packages for ruby
apk add openssl openrc ruby ruby-doc ruby-bundler ruby-dev g++ libffi-dev musl-dev sudo bash make
# Install gems for inspec
gem install bundler --no-document json method_source rake pry rainbow rspec rspec-its r-train rubyzip thor inspec inspec-bin
# install google cloud tools
wget -q -O /tmp/google-cloud-sdk.tgz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
tar xzf /tmp/google-cloud-sdk.tgz -C /usr/lib/
rm /tmp/google-cloud-sdk.tgz
ln -s /lib /lib64
export PATH=$PATH:/usr/lib/google-cloud-sdk/bin > /etc/environment
gcloud config set core/disable_usage_reporting true
gcloud config set component_manager/disable_update_check true
gcloud config set metrics/environment github_docker_image
gcloud components install kubectl docker-credential-gcr --quiet
# clean up
rm -rf /tmp/*
rm -rf /var/cache/apk/*
rm -rf /var/tmp/*










