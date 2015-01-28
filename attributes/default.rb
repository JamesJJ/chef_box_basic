
default["box_basic"]["set_shell_preferences"] = true
default["box_basic"]["use_cloudinit_hostname"] = false

default["box_basic"]["install_packages"] = [ "yum-utils","bind-utils","traceroute","telnet","screen","ruby","rubygems","git", "python-pip", "ntp" ]

# CENTOS6 default["box_basic"]["yum_groups_remove"] = [ "X Window System","Desktop Debugging and Performance Tools","MySQL Database client","NFS file server","Network Infrastructure Server","Office Suite and Productivity","Internet Browser","Dial-up Networking Support","Print Server","Printing client","Web Server","E-mail server","Electronic Lab","Fonts","General Purpose Desktop","Graphical Administration Tools","Internet Applications","Java Platform","Directory Client","Legacy X Window System compatibility" ]
default["box_basic"]["yum_groups_remove"] = []

default['box_basic']['iptables_template_cookbook'] = 'box_basic'

default['yum-epel']['repositories'] = %w{epel}

default['authorization']['groups'] = []
default['authorization']['sudo']['groups'] = [ 'wheel' ]
override['authorization']['sudo']['sudoers_defaults'] = [
  '!visiblepw',
  'env_reset',
  'env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR LS_COLORS"',
  'env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"',
  'env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"',
  'env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"',
  'env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"',
  'always_set_home',
  'secure_path = /sbin:/bin:/usr/sbin:/usr/bin'
]
