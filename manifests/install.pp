# == Class gemirro::install
#
# This class is called from gemirro for install.
#
class gemirro::install {

  if $::gemirro::dependancy_packages {
    package { $::gemirro::dependancy_packages:
      ensure   => present,
      before   => Package[$::gemirro::package_name]
    }
  }

  if $::gemirro::manage_package {
    package { $::gemirro::package_name:
      ensure   => present,
      provider => $::gemirro::package_provider,
    }
  }

}
