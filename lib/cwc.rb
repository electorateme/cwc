# CWC API

# CWC related libs
require "cwc/version"

#Resources
require 'yaml'

module Cwc
  @api_base = "https://test-cwc.house.gov"
  @api_version = "2"

  class << self
    attr_accessor :api_key, :api_base, :api_version

    def api_url(url='')
      @api_base + url
    end
  end

end
