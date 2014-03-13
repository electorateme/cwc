require "cwc/version"

module Cwc
  class Api
    def initialize
      #
    end

    # @return [Configuration] The configuration singleton.
    def self.configuration
      @configuration ||= Cwc::Configuration.new
    end
    
  end

  class Configuration
    def initialize
      @api_key = "something"
    end
    
    # API key for accessing the CWC API
    #
    # @example
    # Adyen.configuration.payment_flow = :select
    #
    # @return [String]
    attr_accessor :api_key
    
  end

end
