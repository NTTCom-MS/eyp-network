# == Class: network
#
class network inherits network::params {

  if($network::params::use_netplan)
  {
    include ::netplan
  }
  else
  {
    include ::network::service
  }


}
