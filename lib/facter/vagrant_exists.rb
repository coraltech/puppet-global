Facter.add(:vagrant_exists) do
  confine :kernel => :linux
  setcode do
    vagrant_exists = false
    
    begin
      Facter::Util::Resolution::exec('id vagrant 2> /dev/null')
      
      if $?.exitstatus == 0
        vagrant_exists = true
      end
      
    rescue Exception # Prevent abortions.
    end
    
    if vagrant_exists
      true
    else
      nil  
    end
  end
end