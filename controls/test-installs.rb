control 'os family' do
  impact 1.0
  title 'os family should be linux'
  describe os.family do
   it { should eq 'linux' }
  end
end
control 'os name' do
  impact 1.0
  title 'os name should be alpine'
  describe os.family do
   it { should eq 'alpine' }
  end
end
control 'aws-cli' do
  impact 1.0
  title 'aws-cli should be installed'
  describe package('aws-cli') do
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
  describe package('terraform') do
    it { should be_installed }
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
control 'ansible' do
  impact 1.0
  title 'ansible should be installed'
  describe package('ansible') do
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
control 'bundler' do
  impact 1.0
  title 'bundler should be installed'
  describe gem('gem_package_name', 'bundler') do
  it { should be_installed }
  end
end
control 'json' do
  impact 1.0
  title 'json should be installed'
  describe gem('gem_package_name', 'json') do
  it { should be_installed }
  end
end
control 'method_source' do
  impact 1.0
  title 'method_source should be installed'
  describe gem('gem_package_name', 'method_source') do
  it { should be_installed }
  end
end
control 'rake' do
  impact 1.0
  title 'rake should be installed'
  describe gem('gem_package_name', 'rake') do
  it { should be_installed }
  end
end
