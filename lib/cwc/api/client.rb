require 'net/http'

module Cwc
  module Api
    class Client

      def request(url)
        validate_settings

      end
      
    end
  end
end