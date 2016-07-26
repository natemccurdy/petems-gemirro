# gemirro - Used for managing installation and configuration
# of gemirro (http://gemirro.org/)
#
# @example
#   include gemirro
#
# @example
#   class { 'gemirro':
#     manage_repo    => false,
#     package_name   => 'gemirro-custombuild',
#   }
#
# @author Peter Souter
#
# @param logintitle [String] Title to show on login screen for gemirro
#
# @param manage_package [Boolean] Whether to manage the gemirro package
#
# @param manage_repo [Boolean] Whether to manage the package repositroy
#
# @param package_name [String] Name of the gemirro package
#
# @param package_version [String] Version of the gemirro package to install
#
# @param service_ensure [String] What status the service should be enforced to
#
# @param service_name [String] Name of the gemirro service to manage
#
class gemirro (
  $manage_package   = $::gemirro::params::manage_package,
  $manage_repo      = $::gemirro::params::manage_repo,
  $package_name     = $::gemirro::params::package_name,
  $package_version  = $::gemirro::params::package_version,
  $service_ensure   = $::gemirro::params::service_ensure,
  $service_name     = $::gemirro::params::service_name,
) inherits ::gemirro::params {

  validate_bool($manage_package)
  validate_bool($manage_repo)

  validate_string($package_name)
  validate_string($package_version)
  validate_string($service_ensure)
  validate_string($service_name)

  class { '::gemirro::install': } ->
  class { '::gemirro::config': } ~>
  class { '::gemirro::service': } ->
  Class['::gemirro']
}
