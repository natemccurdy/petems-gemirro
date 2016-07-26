# == Class gemirro::config
#
# This class is called from gemirro for service config.
#
class gemirro::config {

  file { $::gemirro::config_dir:
    ensure  => 'directory',
    source  => 'puppet:///modules/gemirro/config_dir/',
    recurse => true,
    replace => false,
  }

  file { "${::gemirro::config_dir}/config.rb":
    ensure  => 'file',
    content => template('gemirro/config.rb.erb')
  }
}
