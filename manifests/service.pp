class network::service(
                        $manage_service=true,
                        $manage_docker_service=false,
                        $ensure ='running',
                        $enable =true,
                      ) inherits network::params {

  validate_bool($manage_docker_service)
  validate_bool($manage_service)
  validate_bool($enable)

  if(getvar('::eyp_docker_iscontainer')==undef or
      getvar('::eyp_docker_iscontainer')==false or
      getvar('::eyp_docker_iscontainer') =~ /false/ or
      $manage_docker_service)
  {
    exec { 'network restart' :
      command     => $network::params::service_restart_exec,
      refreshonly => true,
      path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    }
  }

}
