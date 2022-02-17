class network::params {

  case $::osfamily
  {
    'redhat':
    {
      $service_restart_exec='service network restart'
      case $::operatingsystemrelease
      {
        /^[5-8].*$/:
        {
          $use_netplan=false
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }
    }
    'Debian':
    {
      $service_restart_exec='/sbin/ifdown -a && /sbin/ifup -a'
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^1[46].*$/:
            {
              $use_netplan=false
            }
            /^18.*$/:
            {
              $use_netplan=true
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
