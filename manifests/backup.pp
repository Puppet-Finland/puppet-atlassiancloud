#
# == Class: atlassiancloud::backup
#
# Backup Atlassian Cloud JIRA / Confluence instances using 
# automatic-cloud-backup and a cronjob.
#
# == Parameters
#
# [*ensure*]
#   Status of the backup. Either 'present' or 'absent'. The 
#   automatic-cloud-backup repository will be kept at the latest version if this 
#   is set to 'present'. Defaults to 'present'.
# [*username*]
#   Username (for Confluence Cloud authentication)
# [*password*]
#   Password (for Confluence Cloud authentication)
# [*auth_email*]
#   Email address (for JIRA authentication)
# [*api_token*]
#   API token (for JIRA authentication). Must be paired with correct $auth_email.
# [*instance*]
#   The Atlassian Cloud instance. In practice the first part of the FQDN. For 
#   example, for 'myproject.atlassian.net' value of $instance would be 
#   'myproject'.
# [*output_dir*]
#   The base directory for the backups. Defaults to '/var/backups/local'.
# [*hour*]
#   Hour(s) when backup job gets run. Defaults to 14.
# [*minute*]
#   Minute(s) when backup job gets run. Defaults to 21.
# [*weekday*]
#   Weekday(s) when backup job gets run. Defaults to '*/2' (every other day). 
#   Due to Atlassian Cloud backup throttling keeping the default is probably the 
#   best approach.
# [*email*]
#   Email address where notifications are sent. Defaults to top-scope variable
#   $::servermonitor.
#
class atlassiancloud::backup
(
    $username,
    $password,
    $auth_email,
    $api_token,
    $instance,
    $ensure = 'present',
    $output_dir = '/var/backups/local',
    $hour = '14',
    $minute = '21',
    $weekday = '*/2',
    $email = $::servermonitor

) inherits atlassiancloud::params
{

    include ::atlassiancloud

    $confluence_backup_script_name = '/opt/automatic-cloud-backup/backup.sh'
    $jira_backup_script_name = '/opt/automatic-cloud-backup/backup-jira-api-token.sh'
    $config_name = '/root/.backup.sh.vars'

    $vcsrepo_ensure = $ensure ? {
        'present' => 'latest',
        'absent'  => 'absent',
        default   => {},
    }

    vcsrepo { '/opt/automatic-cloud-backup':
        ensure   => $vcsrepo_ensure,
        provider => 'git',
        owner    => 'root',
        group    => 'root',
        source   => 'https://github.com/mattock/automatic-cloud-backup.git',
    }

    file { $config_name:
        ensure  => $ensure,
        content => template('atlassiancloud/backup.sh.vars.erb'),
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0700',
    }

    cron { 'backup-atlassian-cloud-cron':
        ensure      => $ensure,
        user        => $::os::params::adminuser,
        environment => "MAILTO=${email}",
        command     => "${confluence_backup_script_name} --source wiki --timestamp false && ${jira_backup_script_name}",
        hour        => $hour,
        minute      => $minute,
        weekday     => $weekday,
    }
}
