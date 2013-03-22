#
# global_hash.rb
#
# See: global_param.rb
#

require File.join(File.dirname(__FILE__), 'utility')

module Puppet::Parser::Functions
  newfunction(:global_hash, :type => :rvalue, :doc => <<-EOS
This function performs a lookup for a variable value in various locations:
See: global_params()
If no value is found in the defined sources, it returns an empty hash ({})
    EOS
) do |args|

    raise(Puppet::ParseError, "global_hash(): Define at least the variable name " +
      "given (#{args.size} for 1)") if args.size < 1

    values = function_global_param([ args[0], args[1], 'array' ])
    return Global::Utility.merge(values)
  end
end
