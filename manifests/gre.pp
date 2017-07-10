#
# ubuntu: http://systemadmin.es/2014/06/configuracion-de-tunel-gre-en-debian-ubuntu
# centos: http://systemadmin.es/2014/06/configuracion-tunel-gre-en-centos
#
define network::gre(
                      $peer_outer_ipaddr,
                      $peer_inner_ipaddr,
                      $my_inner_ipaddr,
                      $dev             = $name,
                      $my_outer_ipaddr = undef,

                    ) {
  #
  network::interface { $dev:
    type              => 'gre',
    peer_outer_ipaddr => $peer_outer_ipaddr,
    peer_inner_ipaddr => $peer_inner_ipaddr,
    my_inner_ipaddr   => $my_inner_ipaddr,
    my_outer_ipaddr   => $my_outer_ipaddr,
  }

}
