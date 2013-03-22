
module Global
  class Utility
    
    #---------------------------------------------------------------------------
    # Hash operations
    
    def self.merge(hashes, merge_arrays = false)
      value = {}
      return value unless hashes && hashes.is_a?(Array)
      
      begin
        require 'coral-core'
        value = Coral::Util::Data.merge(hashes, merge_arrays)
        
      rescue LoadError
        hashes.each do |hash|
          if hash && hash.is_a?(Hash)
            value = recursive_merge(value, hash, merge_arrays)  
          end      
        end  
      end
      return internalize(value)
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
    
    #---
    
    def self.internalize(value)
      result = value
      
      if value.is_a?(Array)
        result = []
        value.each do |item|
          result << internalize(item)
        end
      
      elsif value.is_a?(Hash)
        result = {}
        value.each do |key, item|
          result[key] = internalize(item)
        end
          
      elsif value.is_a?(String)
        result = value
        case value
        when /^\s*(true|TRUE|True)\s*$/
          result = true
        when /^\s*(false|FALSE|False)\s*$/
          result = false
        when /^\s*(undef|UNDEF)\s*$/
          result = nil
        end
      end
      return result
    end
  end
end