#
# hiera_is_available.rb
#
# This function checks if Hiera is fully configured and ready to query.
#
module Puppet::Parser::Functions
  newfunction(:hiera_is_available, :type => :rvalue, :doc => <<-EOS
This function checks if Hiera is fully configured and ready to query.
    EOS
) do |arguments|

    begin
      if Puppet::Parser::Functions.function('hiera') && lookupvar("::hiera_ready")
        return true
      end
    
    rescue Exception # Prevent abortions.
    end
    
    return false
  end
end
