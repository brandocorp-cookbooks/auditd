require 'spec_helper'

describe 'auditd::default' do

  package_name = case os[:family]
                 when 'debian','ubuntu'
                   'auditd'
                 when 'redhat'
                   'audit'
                 end

  describe package(package_name) do
    it { is_expected.to be_installed }
  end

  describe service('auditd') do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  describe file('/etc/audit/audit.rules') do
    it { is_expected.to be_file }
    it { is_expected.to be_mode 640 }
    it { is_expected.to be_owned_by 'root' }
    its(:content) { is_expected.to match '# First rule - delete all' }
    its(:content) { is_expected.to match(/^\-D$/) }
    its(:content) { is_expected.to match '# Increase the buffers to survive' }
    its(:content) { is_expected.to match(/^\-b 320$/) }
  end
end
