# == Class gemirro::service
#
# This class is meant to be called from gemirro.
# It ensure the service is running.
#
class gemirro::service {

  if $::gemirro::manage_service {
    service { $::gemirro::service_name:
      ensure   => 'running',
      start    => "gemirro server -c ${::gemirro::config_dir}/config.rb --start",
      restart  => "gemirro server -c ${::gemirro::config_dir}/config.rb --restart",
      stop     => "gemirro server -c ${::gemirro::config_dir}/config.rb --stop",
      status   => "gemirro server -c ${::gemirro::config_dir}/config.rb --status",
      provider => base,
    }
  }
}
