control 'aws-cli' do
  impact 1.0
  title 'aws-cli should be installed'
  describe package('aws-cli') do
    it { should be_installed }
  end
end

control 'curl' do
  impact 1.0
  title 'curl should be installed'
  describe package('curl') do
    it { should be_installed }
  end
end

control 'wget' do
  impact 1.0
  title 'wget should be installed'
  describe package('wget') do
    it { should be_installed }
  end
end

control 'make' do
  impact 1.0
  title 'make should be installed'
  describe package('make') do
    it { should be_installed }
  end
end

control 'bash' do
  impact 1.0
  title 'bash should be installed'
  describe package('bash') do
    it { should be_installed }
  end
end

control 'py3-yaml' do
  impact 1.0
  title 'py3-yaml should be installed'
  describe package('py3-yaml') do
    it { should be_installed }
  end
end

control 'py3-s3transfer' do
  impact 1.0
  title 'py3-s3transfer should be installed'
  describe package('py3-s3transfer') do
    it { should be_installed }
  end
end

control 'py3-rsa' do
  impact 1.0
  title 'py3-rsa should be installed'
  describe package('py3-rsa') do
    it { should be_installed }
  end
end

control 'py3-jmespath' do
  impact 1.0
  title 'py3-jmespath should be installed'
  describe package('py3-jmespath') do
    it { should be_installed }
  end
end

control 'py3-docutils' do
  impact 1.0
  title 'py3-docutils should be installed'
  describe package('py3-docutils') do
    it { should be_installed }
  end
end

control 'py3-colorama' do
  impact 1.0
  title 'py3-colorama should be installed'
  describe package('py3-colorama') do
    it { should be_installed }
  end
end

control 'terraform' do
  impact 1.0
  title 'terraform should be installed'
  describe file('/usr/bin/terraform') do
    it { should exist }
  end
end

control 'packer' do
  impact 1.0
  title 'packer should be installed'
  describe file('/usr/bin/packer') do
    it { should exist }
  end
end

control 'py3-botocore' do
  impact 1.0
  title 'py3-botocore should be installed'
  describe package('py3-botocore') do
    it { should be_installed }
  end
end

control 'aws-cli' do
  impact 1.0
  title 'aws-cli should be installed'
  describe package('aws-cli') do
    it { should be_installed }
  end
end

control 'ruby-webrick' do
  impact 1.0
  title 'ruby-webrick should be installed'
  describe package('ruby-webrick') do
    it { should be_installed }
  end
end

control 'python3' do
  impact 1.0
  title 'python3 should be installed'
  describe package('python3') do
    it { should be_installed }
  end
end

control 'groff' do
  impact 1.0
  title 'groff should be installed'
  describe package('groff') do
    it { should be_installed }
  end
end

control 'gcloud' do
  impact 1.0
  title 'gcloud should be installed'
  describe file('/usr/lib/google-cloud-sdk/bin/gcloud') do
  it { should exist }
  end
end

control 'kubectl' do
  impact 1.0
  title 'kubectl should be installed'
  describe file('/usr/lib/google-cloud-sdk/bin/kubectl') do
  it { should exist }
  end
end

control 'inspec' do
  impact 1.0
  title 'inspec should be installed'
  describe file('/usr/lib/ruby/gems/2.7.0/gems/inspec-4.21.3') do
  it { should exist }
  end
end

control 'ansible' do
  impact 1.0
  title 'ansible should be installed'
  describe file('/usr/bin/ansible') do
  it { should exist }
  end
end

control 'ansible again' do
  impact 1.0
  title 'ansible should be installed'
  describe pip('ansible') do
  it { should be_installed }
  end
end

control 'ansible lint' do
  impact 1.0
  title 'ansible lint should be installed'
  describe pip('ansible-lint') do
  it { should be_installed }
  end
end

control 'pip' do
  impact 1.0
  title 'pip should be installed'
  describe pip('pip') do
  it { should be_installed }
  end
end
