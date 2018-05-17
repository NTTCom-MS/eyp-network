require 'ipaddr'

Puppet::Parser::Functions::newfunction(:netmask2cidr, :type => :rvalue, :doc => <<-EOS
Transform netmask to CIDR notation
EOS
) do |args|
  raise(Puppet::ParseError, "netmask2cidr() wrong number of arguments. #{args.size} vs 1)") if args.size != 1

  arg = args[0]

  return IPAddr.new(arg).to_i.to_s(2).count("1")

end
