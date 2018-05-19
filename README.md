# atlassiancloud

A Puppet module for managing (backing up of) the Atlassian Cloud.

# Module usage

Automate backups of your Atlassian Cloud instance:

    class { '::atlassiancloud::backup':
        ensure     => 'present',
        username   => 'johndoe',
        password   => 'secret',
        instance   => 'myinstance',
        output_dir => '/var/backups/local',
        hour       => 9,
        minute     => 9,
    }

For details, see [backup.pp](manifests/backup.pp).

