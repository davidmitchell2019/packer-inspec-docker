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
  describe os.name do
   it { should eq 'alpine' }
  end
end

control 'os release' do
  impact 1.0
  title 'os release should be set from packer'
  describe os.release do
   it { should eq input('os-release') }
  end
end
