# == Class: atlassiancloud
#
# This class is empty. All functionality is currently in backup.pp.
#
# == Authors
#
# Samuli Seppänen <samuli@openvpn.net>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class atlassiancloud
(

) inherits atlassiancloud::params
{
    include ::atlassiancloud::prequisites
}
