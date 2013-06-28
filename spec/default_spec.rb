require 'spec_helper'

platforms = {
  :centos => {
    :packages  => ['ruby', 'telnet'],
    :versions => ['10.04', '12.04']
  },
  :debian => {
    :packages  => ['ruby', 'telnet'],
    :versions => ['6.0.5']
  },
  :ubuntu => {
    :packages  => ['ruby', 'telnet'],
    :versions => ['6.0.5']
  },
}

platforms.each do |platform, package_info|
  packages = package_info[:packages]
  versions = package_info[:versions]

  versions.each do |version|
    describe "On #{platform} (#{version})" do
      before do
        Fauxhai.mock('platform' => platform, 'version' => version)
      end

      let(:chef_run) { ChefSpec::ChefRunner.new.converge('drb::default')}

      packages.each do |package|
        it "installs the #{package} package" do
          expect(chef_run).to install_package(package)
        end
      end

      it "creates a DRb script from the drb-server template" do
        expect(chef_run).to create_file_with_content '/home/vagrant/drb-server.rb', %r|druby://0.0.0.0:#{node[:drb][:port]}|
        file = chef_run.template('/home/vagrant/drb-server.rb')
        expect(file).to be_owned_by('vagrant', 'vagrant')
      end
    end
  end
end