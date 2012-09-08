#
# global_param.rb
#
# This function performs a lookup for a variable value in various locations
# following this order
# - Hiera backend, if present (no prefix)
# - ::varname
# - ::common::varname
# - {default parameter}
#
# Inspired by example42 -> params_lookup.rb
#
module Puppet::Parser::Functions
  newfunction(:global_param, :type => :rvalue, :doc => <<-EOS
This function performs a lookup for a variable value in various locations following this order:
- Hiera backend, if present (no prefix)
- ::varname
- ::common::varname
- {default parameter}
If no value is found in the defined sources, it returns an empty string ('')
    EOS
) do |args|

    raise(Puppet::ParseError, "global_param(): Define at least the variable name " +
      "given (#{args.size} for 1)") if args.size < 1

    Puppet::Parser::Functions.autoloader.loadall
    
    value         = ''
    var_name      = args[0]
    default_value = ( args[1] ? args[1] : '' )
    context       = ( args[2] ? args[2] : '' )
    
    if function_hiera_is_available
      case context
      when 'array'
        value = function_hiera_array("#{var_name}",'')
      when 'hash'
        value = function_hiera_hash("#{var_name}",'')
      else
        value = function_hiera("#{var_name}",'')
      end
    end

    value = lookupvar("::#{var_name}") if (value == :undefined || value == '')
    value = lookupvar("::data::common::#{var_name}") if (value == :undefined || value == '')
    value = default_value if (value == :undefined || value == '')
    
    return value
  end
end
