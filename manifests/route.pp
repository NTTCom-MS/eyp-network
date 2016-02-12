define network::route (
                        $eth,
                        $gw,
                        $network=$name,
                        $ensure = 'present',
                        $order='01',
                        $network_managed=true,
                      ) {

  include ::network

  if($network_managed)
  {
    $notify_exec=Exec['network restart']
  }
  else
  {
    $notify_exec=undef
  }

  case $::osfamily
  {
    'RedHat':
    {
      if ! defined(Concat["/etc/sysconfig/network-scripts/route-${eth}"])
      {
        concat { "/etc/sysconfig/network-scripts/route-${eth}":
          ensure => $ensure,
          mode   => '0644',
          owner  => 'root',
          group  => 'root',
          notify => $notify_exec,
        }

        concat::fragment{ "route ${eth} header":
          target  => "/etc/sysconfig/network-scripts/route-${eth}",
          order   => '00',
          content => "# puppet managed file\n",
        }
      }

      concat::fragment{ "route ${name} ${gw} ${network}":
        target  => "/etc/sysconfig/network-scripts/route-${eth}",
        order   => $order,
        content => template("${module_name}/redhat/route.erb"),
      }

    }
    'Debian':
    {
      #/etc/network/if-up.d/
      if ! defined(Concat["/etc/network/if-up.d/z${order}-routes-${eth}"])
      {
        concat { "/etc/network/if-up.d/z${order}-routes-${eth}":
          ensure => $ensure,
          mode   => '0755',
          owner  => 'root',
          group  => 'root',
          notify => $notify_exec,
        }

        concat::fragment{ "route ${name} ${gw} ${network} header ifup":
          target  => "/etc/network/if-up.d/z${order}-routes-${eth}",
          order   => '00',
          content => template("${module_name}/debian/ifupdown_header.erb"),
        }

        concat::fragment{ "route ${name} ${gw} ${network} footer ifup":
          target  => "/etc/network/if-up.d/z${order}-routes-${eth}",
          order   => '99',
          content => "fi\n",
        }
      }

      concat::fragment{ "route ${name} ${gw} ${network} content ifup":
        target  => "/etc/network/if-up.d/z${order}-routes-${eth}",
        order   => $order,
        content => template("${module_name}/debian/ifup/ifup_content.erb"),
      }

      #/etc/network/if-down.d/
      if ! defined(Concat["/etc/network/if-down.d/z${order}-routes-${eth}"])
      {
        concat { "/etc/network/if-down.d/z${order}-routes-${eth}":
          ensure => $ensure,
          mode   => '0755',
          owner  => 'root',
          group  => 'root',
          notify => $notify_exec,
        }

        concat::fragment{ "route ${name} ${gw} ${network} header ifdown":
          target  => "/etc/network/if-down.d/z${order}-routes-${eth}",
          order   => '00',
          content => template("${module_name}/debian/ifupdown_header.erb"),
        }

        concat::fragment{ "route ${name} ${gw} ${network} footer ifdown":
          target  => "/etc/network/if-down.d/z${order}-routes-${eth}",
          order   => '99',
          content => "fi\n",
        }
      }

      concat::fragment{ "route ${name} ${gw} ${network} content ifdown":
        target  => "/etc/network/if-down.d/z${order}-routes-${eth}",
        order   => $order,
        content => template("${module_name}/debian/ifdown/ifdown_content.erb"),
      }

    }
    default: { fail('Operating system not supported')  }
  }

}
