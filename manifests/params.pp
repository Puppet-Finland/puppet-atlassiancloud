#
# == Class: atlassiancloud::params
#
# Defines some variables based on the operating system
#
class atlassiancloud::params {

    include ::os::params

    case $::osfamily {
        'RedHat': {
            # Nothing here
        }
        'Debian': {
            # Nothing here
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
