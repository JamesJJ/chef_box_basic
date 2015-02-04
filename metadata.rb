name             'box_basic'
maintainer       'github@jamesjj.net'
maintainer_email 'github@jamesjj.net'
license          'MIT'
description      'Installs/Configures instances'
long_description      'Installs/Configures instances'
version          '0.2.3'

depends 'users'
depends 'chef-solo-search'
depends 'yum-epel'
# for your Berksfile:
# cookbook 'shell_preferences', github: 'JamesJJ/chef_shell_preferences', tag: 'v0.1.3'
depends 'shell_preferences'
