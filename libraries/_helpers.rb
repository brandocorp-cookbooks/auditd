module Auditd
  module Helper
    module Recipe
      def auditd_package
        value_for_platform_family(
          ['debian'] => 'auditd',
          ['rhel', 'fedora'] => 'audit'
        )
      end
    end

    module Template
      def auditd_rulesets
        node.run_state['auditd']['rulesets']
      end
    end
  end
end

Chef::Recipe.send(:include, Auditd::Helper::Recipe)
Chef::Resource::Template.send(:include, Auditd::Helper::Template)
