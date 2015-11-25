resource_name :auditd_ruleset

property :rules, Array, default: []
property :comment, String, default: nil

default_action :include

action :include do
  check_run_state
  Chef::Log.debug "before: #{rulesets}"
  include_rules
  Chef::Log.debug "after: #{rulesets}"
  if has_rules?
    new_resource.updated_by_last_action(false)
  else
    new_resource.updated_by_last_action(true)
  end
end

def include_rules
  rulesets[name] = Mash.new({
    comment: comment,
    rules: rules
  })
end

def check_run_state
  node.run_state['auditd'] ||= {}
  node.run_state['auditd']['rulesets'] ||= {}
end

def rulesets
  node.run_state['auditd']['rulesets']
end

def has_rules?
  rules.each do |rule|
    return false unless existing_rule?(rule)
  end
  true
end

def current_rules
  ::File.open('/etc/audit/audit.rules').readlines.map(&:strip)
end

def existing_rule?(text)
  current_rules.include? text
end
