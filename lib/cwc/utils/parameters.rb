module Cwc
  module Utils
    class Parameters
      @@parameters = {}

      # Set and Get for configuration
      def set property, value
        @@parameters[property] = value
      end

      def get property
        @@parameters[property]
      end

      def parameters
        @@parameters
      end

      # Helper method to set default parameters when initializing a class
      def self.default_parameter property, value
        @@parameters[property] = value
      end
    end
  end
end