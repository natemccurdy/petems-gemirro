require 'spec_helper'

describe 'gemirro' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "gemirro class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to create_class('gemirro') }

          it { is_expected.to contain_class('gemirro::params') }
          it { is_expected.to contain_class('gemirro::install').that_comes_before('Class[gemirro::config]') }
          it { is_expected.to contain_class('gemirro::config') }
          it { is_expected.to contain_class('gemirro::service').that_subscribes_to('Class[gemirro::config]') }

          it { is_expected.to contain_service('gemirro') }
          it { is_expected.to contain_package('gemirro').with_ensure('present') }

          it { is_expected.to contain_file('/opt/gemirro/').with({
            'ensure' => 'directory',
            'source' => 'puppet:///modules/gemirro/config_dir/',
            'recurse' => true,
            'replace' => false,
          }) }

          it { is_expected.to contain_file('/opt/gemirro/config.rb').with({
            'ensure' => 'file',
          }) }

          it { is_expected.to contain_file('/opt/gemirro/config.rb').with_content(/This is the main configuration file for your RubyGems mirror. Here you can/) }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'gemirro class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      context 'shows failure' do
        it { expect { is_expected.to create_class('gemirro') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
      end
    end
  end
end
