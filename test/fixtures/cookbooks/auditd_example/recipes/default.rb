include_recipe 'auditd::default'

# write default configuration
auditd_config '/etc/audit/auditd.conf'

# build the default rules
auditd_ruleset 'default' do
  comment 'First rule - delete all'
  rules ['-D']
end

auditd_ruleset 'buffers' do
  comment 'Increase the buffers to survive stress events.'
  rules ['-b 320']
end

# write the rules we defined above
auditd_rules '/etc/audit/audit.rules'
