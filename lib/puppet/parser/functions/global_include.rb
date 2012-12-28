#
# global_include.rb
#
# This function includes classes based on dynamic configurations.
# following this order
# - Hiera backend, if present (no prefix)
# - ::varname
# - ::common::varname
# - {default parameter}
#
module Puppet::Parser::Functions
  newfunction(:global_include, :doc => <<-EOS
This function performs a lookup for a variable value in various locations following this order:
- Hiera backend, if present (no prefix)
- ::varname
- ::common::varname
- {default parameter}
If no value is found in the defined sources, it does not include any classes.
    EOS
) do |args|

    raise(Puppet::ParseError, "global_include(): Define at least the variable name " +
      "given (#{args.size} for 1)") if args.size < 1

    Puppet::Parser::Functions.autoloader.loadall
    
    var_name = args[0]
    classes  = function_global_array([ var_name, [] ])
    
    if ! classes.empty?
      function_hiera_include([ var_name ])
    end
  end
end
