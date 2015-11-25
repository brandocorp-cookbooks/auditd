resource_name :auditd_rules

property :path,
  String,
  name_attribute: true

property :rulesets,
  Array,
  default: {}

action :write do
  service 'auditd' do
    supports [:reload, :restart, :status]
    action :nothing
  end

  template path do
    source 'audit.rules.erb'
    cookbook 'auditd'
    owner 'root'
    group 'root'
    mode '0640'
    variables lazy { {rulesets: auditd_rulesets} }
    notifies :reload, 'service[auditd]', :delayed
  end
end
