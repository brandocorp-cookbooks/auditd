resource_name :auditd_config

property :path,
  String,
  name_attribute: true

# This keyword specifies the full path name to the log file where audit records
# will be stored. It must be a regular file.
property :log_file,
  String,
  default: '/var/log/audit/audit.log'

# The log format describes how the information should be stored on disk. There
# are 2 options: raw and nolog.
property :log_format,
  String,
  default: 'RAW',
  regex: /raw|nolog/i

# This keyword specifies the group that is applied to the log file's
# permissions. The default is root. The group name can be either numeric or
# spelled out.
property :log_group,
  String,
  default: 'root'

# This is a non-negative number that tells the audit damon how much of a
# priority boost it should take. The default is 3. No change is 0.
property :priority_boost,
  Numeric,
  default: 4

# Valid values are none, incremental, data, and sync.
property :flush,
  String,
  default: 'incremental',
  regex: /none|incremental|data|sync/i

# This is a non-negative number that tells the audit damon how many records to
# write before issuing an explicit flush to disk command. this value is only
# valid when the flush keyword is set to incremental.
property :freq,
  Numeric,
  default: 20

# This keyword specifies the number of log files to keep if rotate is given as
# the max_log_file_action. If the number is less than 2, logs are not rotated.
# This number must be 99 or less. The default is 0 - which means no rotation.
property :num_logs,
  Numeric,
  default: 0,
  callbacks: { "check" => proc {|v| v.between?(0, 99) } }

# The dispatcher is a program that is started by the audit daemon when it starts
# up. It will pass a copy of all audit events to that application's stdin. Make
# sure you trust the application that you add to this line since it runs with
# root privileges.
property :dispatcher,
  String,
  default: '/sbin/audispd'

# This  option  controls  how  computer node names are inserted into the audit
# event stream. It has the following choices: none, hostname, fqd, numeric, and
# user.
property :name_format,
  String,
  default: 'none',
  regex: /none|hostname|fqd|numeric|user/

# @note this config value collides with the reserved `name` method
# This is the admin defined string that identifies the machine if user is given
# as the name_format option.
property :name_value,
  String,
  default: nil

# This option controls whether you want blocking/lossless or non-blocking/lossy
# communication between the audit daemon and the dispatcher. Valid values are:
# lossy and lossless. Lossy is the default value.
property :disp_qos,
  String,
  default: 'lossy',
  regex: /loss(y|less)/i

# This keyword specifies the maximum file size in megabytes. When this limit is
# reached, it will trigger a configurable action. The value given must be
# numeric.
property :max_log_file,
  Numeric,
  default: 6

# This parameter tells the system what action to take when the system has
# detected that the max file size limit has been reached. Valid values are
# ignore, syslog, suspend, rotate and keep_logs. If set to ignore, the audit
# daemon does nothing.
property :max_log_file_action,
  String,
  default: 'rotate',
  regex: /ignore|syslog|suspend|rotate|keep_logs/i

# This option should contain a valid email address or alias. The default address
# is root. If the email address is not local to the machine, you must make sure
# you have email properly configured on your machine and network. Also, this
# option requires that /usr/lib/sendmail exists on the machine.
property :action_mail_acct,
  String,
  default: 'root'

# This is a numeric value in megabytes that tells the audit daemon when to
# perform a configurable action because the system is starting to run low on
# disk space.
property :space_left,
  Numeric,
  default: 75

# This parameter tells the system what action to take when the system has
# detected that it is starting to get low on disk space. Valid values are:
# ignore, syslog, email, suspend, single, and halt.
property :space_left_action,
  String,
  default: 'syslog',
  regex: /ignore|syslog|email|suspend|single|halt/i

# This is a numeric value in megabytes that tells the audit daemon when to
# perform a configurable action because the system is running low on disk space.
property :admin_space_left,
  Numeric,
  default: 50

# This parameter tells the system what action to take when the system has
# detected that it is low on disk space. Valid values are ignore, syslog, email,
# suspend, single, and halt.
property :admin_space_left_action,
  String,
  default: 'suspend',
  regex: /ignore|syslog|email|suspend|single|halt/i

# This parameter tells the system what action to take when the system has
# detected that the partition to which log files are written has become full.
# Valid values are ignore, syslog, suspend, single, and halt.
property :disk_full_action,
  String,
  default: 'suspend',
  regex: /ignore|syslog|suspend|single|halt/i

# This parameter tells the system what action to take whenever there is an error
# detected when writing audit events to disk or rotating logs. Valid values are
# ignore, syslog, suspend, single, and halt.
property :disk_error_action,
  String,
  default: 'suspend',
  regex: /ignore|syslog|suspend|single|halt/i

# This is a numeric value in the range 1..65535 which, if specified, causes
# auditd to listen on the corresponding TCP port for audit records from remote
# systems.
property :tcp_listen_port,
  Numeric,
  default: nil,
  callbacks: { "check" => proc {|v| v.between?(1, 65535) } }

# This  is  a  numeric  value  which indicates how many pending (requested but
# unaccepted) connections are allowed. The default is 5.
property :tcp_listen_queue,
  Numeric,
  default: 5

# This is a numeric value which indicates how many concurrent connections from
# one IP address is allowed.  The default is 1 and the maximum is 1024.
property :tcp_max_per_addr,
  Numeric,
  default: 1,
  callbacks: { "check" => proc {|v| v.between?(1, 1024) } }

# This setting determines whether or not to use tcp_wrappers to discern
# connection attempts that are from allowed machines. Legal values are either
# yes, or no. The default value is yes.
property :use_libwrap,
  String,
  regex: /yes|no/i

# This parameter may be a single numeric value or two values separated by a dash
# (no spaces allowed). It indicates which client ports are allowed for incoming
# connections. If not specified, any port is allowed. Allowed values are
# 1..65535.
property :tcp_client_ports,
  String,
  regex: /\d+-?\d*/

# This parameter indicates the number of seconds that a client may be idle
# (i.e. no data from them at all) before auditd complains. This is used to close
# inactive connections if the client machine has a problem where it cannot
# shutdown the connection cleanly. Note that this is a global setting, and must
# be higher than any individual client heartbeat_timeout setting, preferably by
# a factor of two.  The default is zero, which disables this check.
property :tcp_client_max_idle,
  Numeric,
  default: 0

# If set to "yes", Kerberos 5 will be used for authentication and encryption.
# The default is "no".
property :enable_krb5,
  String,
  default: 'no',
  regex: /yes|no/i

# This is the principal for this server. The default is "auditd". Given this
# default, the server will look for a key named like auditd/hostname@EXAMPLE.COM
# stored in /etc/audit/audit.key to authenticate itself, where hostname is the
# canonical name for the server's host, as returned by a DNS lookup of its IP
# address.
property :krb5_principal,
  String,
  default: nil

# Location of the key for this client's principal. Note that the key file must
# be owned by root and mode 0400. The default is /etc/audit/audit.key
property :krb5_key_file,
  String,
  default: nil

action :write do
  template path do
    source 'auditd.conf.erb'
    cookbook 'auditd'
    owner 'root'
    group 'root'
    mode '0640'
    variables(
      config: self.dup
    )
  end
end
