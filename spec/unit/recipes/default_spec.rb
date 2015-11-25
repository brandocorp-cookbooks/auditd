#
# Cookbook Name:: auditd
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'auditd::default' do
  context 'When all attributes are default, on a debian-family system' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node,server|
        node.automatic['platform_family'] = 'debian'
      end.converge(described_recipe)
    end

    it 'installs auditd' do
      expect(chef_run).to install_package('auditd')
    end

    it 'starts and enables the auditd service' do
      expect(chef_run).to start_service('auditd')
      expect(chef_run).to enable_service('auditd')
    end
  end

  context 'When all attributes are default on a rhel-family system' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node,server|
        node.automatic['platform_family'] = 'rhel'
      end.converge(described_recipe)
    end

    it 'installs auditd' do
      expect(chef_run).to install_package('audit')
    end

    it 'starts and enables the auditd service' do
      expect(chef_run).to start_service('auditd')
      expect(chef_run).to enable_service('auditd')
    end
  end
end
