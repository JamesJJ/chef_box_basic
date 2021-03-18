name             'box_basic'
maintainer       'JamesJJ'
maintainer_email 'JamesJJ@users.noreply.github.com'
license          'MIT'
description      'Installs/Configures instances'
long_description      'Installs/Configures instances'
version          '0.2.6'

depends 'users'
depends 'chef-solo-search'
depends 'yum-epel'
# for your Berksfile:
# cookbook 'shell_preferences', github: 'JamesJJ/chef_shell_preferences', tag: 'v0.1.3'
depends 'shell_preferences'
