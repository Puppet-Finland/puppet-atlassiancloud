# atlassiancloud

A Puppet module for managing (backing up of) the Atlassian Cloud.

# Module usage

Automate backups of your Atlassian Cloud instance:

    classes:
        - atlassiancloud::backup
    
    atlassiancloud::backup::ensure: 'present'
    atlassiancloud::backup::username: 'johndoe'
    atlassiancloud::backup::password: 'secret'
    atlassiancloud::backup::instance: 'myinstance'
    atlassiancloud::backup::output_dir: '/var/backups/local'
    atlassiancloud::backup::hour: 9
    atlassiancloud::backup::minute: 9

For details, see

* [Class: atlassiancloud::backup](manifests/backup.pp)

# Dependencies

See [metadata.json](metadata.json).

# Operating system support

This module has been tested on

* Debian 7

Any *NIX-style operating system should work out of the box or with small
modifications.

For details see [params.pp](manifests/params.pp).
