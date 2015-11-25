#
# Cookbook Name:: auditd
# Recipe:: default
#
# Copyright (c) 2015 All Rights Reserved.

package auditd_package

service 'auditd' do
  supports [:restart, :reload, :status]
  action [:start, :enable]
end
