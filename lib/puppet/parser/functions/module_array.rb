#
# module_array.rb
#
# See: module_param.rb
#
module Puppet::Parser::Functions
  newfunction(:module_array, :type => :rvalue, :doc => <<-EOS
This function performs a lookup for a variable value in various locations:
See: module_params()
If no value is found in the defined sources, it returns an empty string ('')
    EOS
) do |args|

    raise(Puppet::ParseError, "module_array(): Define at least the variable name " +
      "given (#{args.size} for 1)") if args.size < 1

    return function_unique([ function_module_param([ args[0], args[1], 'array' ]) ])
  end
end
