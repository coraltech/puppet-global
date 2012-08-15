#
# global_array.rb
#
# See: global_param.rb
#
module Puppet::Parser::Functions
  newfunction(:global_array, :type => :rvalue, :doc => <<-EOS
This function performs a lookup for a variable value in various locations:
See: global_params()
If no value is found in the defined sources, it returns an empty string ('')
    EOS
) do |args|

    raise(Puppet::ParseError, "global_array(): Define at least the variable name " +
      "given (#{args.size} for 1)") if args.size < 1

    Puppet::Parser::Functions.autoloader.loadall
    
    return function_unique(function_global_param(args[0], args[1], 'array'))
  end
end
