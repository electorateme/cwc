require 'cwc/utils/url'

module Cwc
  class << self
    # Includes
    include Cwc::Utils::URL

    @api_version_number = "2.0"
    @api_version = "v2"
    @api_base = "http://test-cwc.house.gov/"

    # Attributes
    attr_accessor :api_key, :api_base, :api_version, :api_version_number

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
        raise SettingsError.new('No API version provided. Set your API base using "Cwc.api_version = <API-VERSION>"')
      end
    end

    # Test function
    def test_settings
      puts "API Key: "          + self.api_key = "ABC123"
      puts "API Version: "      + self.api_version = "v2"
      puts "API Base: "         + self.api_base = "http://hepu.ngrok.com"
      puts "API URL example: "  + self.api_url(self.api_version+"/message")
      true
    end
  end
end