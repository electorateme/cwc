require 'net/http'
require 'cwc/cwc'

module Cwc
  module Api
    class Client < Cwc
      def initialize
        validate_settings
      end

      def request(method, path, params = {}, headers = {})
        case method.upcase
        when 'GET'
          uri = @api_base
          uri.path = path
          uri.query = URI.encode_www_form(params)
          response = Net::HTTP.get_response(uri)
          puts "Response: "+response.inspect
        when 'POST'

        else

        end
      end

      def request_headers
        
      end
      
    end
  end
end