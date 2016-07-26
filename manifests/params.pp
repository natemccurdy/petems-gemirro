# == Class gemirro::params
#
# This class is meant to be called from gemirro.
# It sets variables according to platform.
#
class gemirro::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'gemirro'
      $service_name = 'gemirro'
    }
    'RedHat': {
      $package_name = 'gemirro'
      $service_name = 'gemirro'
      $dependancy_packages = ['make', 'gcc', 'gcc-c++']
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }

  # Defaults for all Operating Systems
  $manage_package   = true
  $manage_repo      = true
  $manage_service   = true
  $package_provider = 'gem'
  $package_version  = 'installed'
  $service_ensure   = 'running'

  $config_dir       = '/opt/gemirro'
}
