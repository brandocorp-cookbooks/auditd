# auditd

auditd - The Linux Audit daemon

## Requirements

### Platform

* Debian (= 8.1)
* CentOS (= 7.1)
* Ubuntu (= 14.04)

## Recipes

### auditd::default

Installs the auditd package and starts, enables the auditd service.

## Resource/Provider

### `auditd_config`

This resource manages the `auditd` service configuration file. All configuration parameters are supported. If you find one is missing please file an issue.

#### Actions

- `:write` _(default)_

#### Properties

<table>
 <thead>
    <tr>
      <td>Name</td>
      <td>Description</td>
      <td>Default</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>:log_file</code></td>
      <td>Full path to the log file where audit records will be stored</td>
      <td><code>/var/log/audit/audit.log</code></td>
    </tr>
    <tr>
      <td><code>:log_format</code></td>
      <td>Describes how the information should be stored on disk</td>
      <td><code>raw</code></td>
    </tr>
    <tr>
      <td><code>:log_group</code></td>
      <td>Specifies the group that is applied to the log file's permissions</td>
      <td><code>root</code></td>
    </tr>
    <tr>
      <td><code>:priority_boost</code></td>
      <td>Tells the audit daemon how much of a priority boost it should take</td>
      <td><code>4</code></td>
    </tr>
    <tr>
      <td><code>:flush</code></td>
      <td>Valid values are none, incremental, data, and sync</td>
      <td><code>incremental</code></td>
    </tr>
    <tr>
      <td><code>:freq</code></td>
      <td>Tells the audit daemon how many records to write before issuing an explicit flush to disk command</td>
      <td><code>20</code></td>
    </tr>
    <tr>
      <td><code>:num_logs</code></td>
      <td>The number of log files to keep</td>
      <td><code>5</code></td>
    </tr>
    <tr>
      <td><code>:disp_qos</code></td>
      <td>Controls whether blocking/lossless or non-blocking/lossy communication between the audit daemon and the dispatcher</td>
      <td><code>lossy</code></td>
    </tr>
    <tr>
      <td><code>:dispatcher</code></td>
      <td>Dispatcher program started by the audit daemon</td>
      <td><code>/sbin/audispd</code></td>
    </tr>
    <tr>
      <td><code>:name_format</code></td>
      <td>Controls how computer node names are inserted into the audit event  stream</td>
      <td><code>none</code></td>
    </tr>
    <tr>
      <td><code>:name_value</code></td>
      <td>String that identifies the machine</td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td><code>:max_log_file</code></td>
      <td>Maximum file size in megabytes</td>
      <td><code>6</code></td>
    </tr>
    <tr>
      <td><code>:max_log_file_action</code></td>
      <td>Action to take when the max file size limit has been reached</td>
      <td><code>rotate</code></td>
    </tr>
    <tr>
      <td><code>:action_mail_acct</code></td>
      <td>A valid email address or alias</td>
      <td><code>root</code></td>
    </tr>
    <tr>
      <td><code>:space_left</code></td>
      <td>Threshold for triggering the <code>space_left_action</code></td>
      <td><code>75</code></td>
    </tr>
    <tr>
      <td><code>:space_left_action</code></td>
      <td>Action to take if the system is low on disk space</td>
      <td><code>syslog</code></td>
    </tr>
    <tr>
      <td><code>:admin_space_left</code></td>
      <td>Threshold for triggering the <code>admin_space_left_action</code></td>
      <td><code>50</code></td>
    </tr>
    <tr>
      <td><code>:admin_space_left_action</code></td>
      <td>Action to take if the system is low on disk space</td>
      <td><code>suspend</code></td>
    </tr>
    <tr>
      <td><code>:disk_full_action</code></td>
      <td>Action to take if partition auditd is writing to has become full</td>
      <td><code>suspend</code></td>
    </tr>
    <tr>
      <td><code>:disk_error_action</code></td>
      <td>Action to take if an error is detected writing to disk</td>
      <td><code>suspend</code></td>
    </tr>
    <tr>
      <td><code>:tcp_listen_port</code></td>
      <td>Causes auditd to listen on the corresponding TCP port</td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td><code>:tcp_listen_queue</code></td>
      <td>Indicates how many pending connections are allowed</td>
      <td><code>5</code></td>
    </tr>
    <tr>
      <td><code>:tcp_max_per_addr</code></td>
      <td>Indicates how many concurrent connections from one IP address is allowed</td>
      <td><code>1</code></td>
    </tr>
    <tr>
      <td><code>:use_libwrap</code></td>
      <td>Determines whether or not to use tcp_wrappers</td>
      <td><code>yes</code></td>
    </tr>
    <tr>
      <td><code>:tcp_client_ports</code></td>
      <td>Indicates which client ports are allowed</td>
      <td><code>nil</code></td>
    </tr>
    <tr>
      <td><code>:tcp_client_max_idle</code></td>
      <td>Indicates the number of seconds that a client may be idle</td>
      <td><code>0</code></td>
    </tr>
    <tr>
      <td><code>:enable_krb5</code></td>
      <td>Determines if Kerberos 5 will be used for authentication and encryption</td>
      <td><code>no</code></td>
    </tr>
    <tr>
      <td><code>:krb5_principal</code></td>
      <td>The principal for this server</td>
      <td><code>auditd</code></td>
    </tr>
    <tr>
      <td><code>:krb5_key_file</code></td>
      <td>Location of the key for this client's principal</td>
      <td><code>nil</code></td>
    </tr>
  </tbody>
</table>

### `auditd_ruleset`

This resource is used to define cumulative rulesets across a `chef-client` run.

#### Actions

- `:include` _(default)_

#### Properties

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>:comment</code></td>
    <td>Descriptive comment to associate with the rules</td>
    <td><code>nil</code></td>
  </tr>
  <tr>
    <td><code>:rules</code></td>
    <td>An <code>Array</code> of <code>String</code> objects representing rules to add</td>
    <td><code>[]</code></td>
  </tr>
</table>

### `auditd_rules`

This resource writes the collective rulesets defined across all `auditd_ruleset` resources to the specified rules file. If the rules have been updated, this resource will trigger a `reload` of the auditd service.

#### Actions

- `:include` _(default)_

## Examples

```ruby
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
```
