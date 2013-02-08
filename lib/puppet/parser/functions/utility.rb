
module Global
  class Utility
    
    #---------------------------------------------------------------------------
    # Hash operations
    
    def self.merge(hashes)
      value = {}
      return value unless hashes && hashes.is_a?(Array)
            
      hashes.each do |hash|
        if hash && hash.is_a?(Hash)
          value = recursive_merge(value, hash)  
        end      
      end
      return value
    end
    
    #---
    
    def self.recursive_merge(overrides, data, merge_arrays = false)
      return data unless overrides
      return overrides unless data
            
      if overrides.is_a?(Hash)
        overrides.each do |name, override|
          if data.is_a?(Hash)
            if data[name]
              data[name] = recursive_merge(override, data[name])
            else
              begin
                item = override.dup
              rescue TypeError
                item = override
              end
              data[name] = recursive_merge(override, item)
            end
          else
            data = overrides
          end
        end
      elsif merge_arrays && overrides.is_a?(Array)
        if data.is_a?(Array)
          data = data | overrides
        else
          data = overrides
        end
      else
        data = overrides
      end
      return data   
    end
  end
end