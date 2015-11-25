#
# Cookbook Name:: auditd
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'auditd::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs auditd' do
      expect(chef_run).to install_package('auditd')
    end

    it 'starts and enables the auditd service' do
      expect(chef_run).to start_service('auditd')
      expect(chef_run).to enable_service('auditd')
    end
  end
end
