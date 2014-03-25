module Cwc
  module Utils
    class Parameters
      @@parameters = {}

      # Set and Get for configuration
      def set property, value, accessible = false
        @@parameters[property] = value
        if accessible
          define_method(property){
            return @@parameters[property]
          }
        end
      end

      def get property
        @@parameters[property]
      end

      def remove property
        @@parameters.delete(property)
        remove_method(property) if method_defined? property
      end

      # Helper method to set default parameters when initializing a class
      def self.default_parameter property, value, accessible = false
        @@parameters[property] = value
        if accessible
          define_method(property){
            return @@parameters[property]
          }
        end
      end
    end
  end
end