resource_name :auditd_ruleset

property :rules, Array, default: []
property :comment, String, default: nil

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
  rulesets["#{name}"] = ::Chef::Mash.new({
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

def existing_rule?(text)
  file = Chef::Util::FileEdit.new('/etc/audit/audit.rules')
  file.search_file_delete_line(/#{Regexp.escape(text)}/)
  file.unwritten_changes?
end
