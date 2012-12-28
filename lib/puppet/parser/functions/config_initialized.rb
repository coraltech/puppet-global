#
# config_initialized.rb
#
# This function checks if Hiera is fully configured and ready to query.
#
module Puppet::Parser::Functions
  newfunction(:config_initialized, :type => :rvalue, :doc => <<-EOS
This function checks if Hiera is fully configured and ready to query.
    EOS
) do ||

    Puppet::Parser::Functions.autoloader.loadall

    begin
      if Puppet::Parser::Functions.function('hiera') && lookupvar("::hiera_ready") == 'true'
        return true
      end
    
    rescue Exception # Prevent abortions.
    end
    
    return false
  end
end
