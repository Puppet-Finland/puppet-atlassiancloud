#
# == Class: atlassiancloud::prequisites
#
# Install prequisites for Atlassian Cloud backups
#
class atlassiancloud::prequisites inherits atlassiancloud::params {

    package { 'jq':
        ensure => 'present',
    }
}
