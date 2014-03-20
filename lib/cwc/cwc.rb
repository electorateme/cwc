require 'cwc/utils/url'

module Cwc
  class << self
    # Includes
    include Cwc::Utils::URL

    @api_version_number = "2.0"
    @api_version = "v2"
    @api_base = "http://test-cwc.house.gov/"

    # Attributes
    attr_accessor :api_key, :api_base
    attr_reader :api_version, :api_version_number

    def api_url url=''
      validate_settings
      @api_base.to_s + url
    end

    def api_base= value
      # Add trailing slash if it's missing
      add_trailing_slash value
      @api_base = value
    end

    def api_base_as_uri
      URI(@api_base)
    end

    def validate_settings
      # Validate API Key
      unless @api_key
        raise AuthenticationError.new('No API key provided. Set your API key using "Cwc.api_key = <API-KEY>"')
      end
      # Validate API base
      unless @api_base
        raise SettingsError.new('No API base provided. Set your API base using "Cwc.api_base = <API-BASE>"')
      end
      # Validate API version
      unless @api_version
        raise SettingsError.new('No API version provided')
      end
    end

    # Test function
    def test_settings
      puts "API Key: "          + @api_key = "ABC123"
      puts "API Base: "         + @api_base = "http://hepu.ngrok.com"
      puts "API URL example: "  + self.api_url(@api_version+"/offices")
      true
    end

    def configure
      puts "API Key: "          + @api_key = "bf4eb605ab14cd99b4dfd7a8ee047715d28b2cb9"
      puts "API Base: "         + @api_base = "https://test-cwc.house.gov"
      puts "API URL example: "  + self.api_url(@api_version+"/message")
      true
    end
  end
end