name 'auditd'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'all_rights'
description 'Installs/Configures auditd'
long_description 'Installs/Configures auditd'
version '0.1.1'

%w(centos debian redhat ubuntu).each do |os|
  supports os
end

recipe 'auditd::default',
  'Installs the auditd package and starts, enables the auditd service.'
