# CWC API

# CWC related libs
require "cwc/version"

#Resources
require 'net/http'

module Cwc
  @api_base = "https://test-cwc.house.gov/"
  @api_version = "v2"

  class << self
    attr_accessor :api_key, :api_base, :api_version

    def api_url(url='')
      @api_base + url
    end

    def request(method, url, api_key, params={}, headers={})
      unless api_key ||= @api_key
        raise AuthenticationError.new('No API key provided. Set your API key using "Cwc.api_key = <API-KEY>"')
      end

      if api_key =~ /\s/
        raise AuthenticationError.new('Your API key is invalid, as it contains whitespace')
      end
    end
  end

end
