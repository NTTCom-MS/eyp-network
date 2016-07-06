Puppet::Parser::Functions::newfunction(:bool2yesno, :type => :rvalue, :doc => <<-EOS
Transform a supposed boolean to yes or no. Pass all other values through.
Given a nil value (undef), bool2yesno will return 'no'
EOS
) do |args|
  raise(Puppet::ParseError, "bool2yesno() wrong number of arguments. #{args.size} vs 1)") if args.size != 1

  arg = args[0]

  if arg.nil? or arg == false or arg =~ /false/i or arg =~ /no/i or arg == :undef
    return 'no'
  elsif arg == true or arg =~ /true/i or arg =~ /yes/i
    return 'yes'
  end

  return arg.to_s
end
