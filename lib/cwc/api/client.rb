require 'net/http'
require 'cwc/cwc'

require 'cwc/utils/xmkl'

module Cwc
  module Api
    class Client
      include Cwc::Utils::XML

      def initialize
        Cwc.validate_settings
      end

      protected
        def request method, path, params = {}, headers = {}
          uri = URI(Cwc.api_url(path.to_s))
          # It is neccesary to send the API key as a GET parameter
          params[:apikey] = Cwc.api_key
          case method.to_s.upcase
          when "GET"
            get uri, params
          when "POST"
            post uri, params
          else
            get uri, params
          end
        end

        # Handles the response from the request done to the API
        def handle_response response
          case response.code
            when "200"
              puts "OK: 200"
              response
            when "400"
              puts "Error with the data sent to the API. Response: 400"
              parse_errors response
            when "404"
              raise ApiError.new("Command not found. Response: 404")
            else
              raise ApiError.new("Error in the request. Response: "+response.code)
          end
        end

      private
        def get uri, params = {}
          uri.query = URI.encode_www_form(params)
          response = Net::HTTP.get_response(uri)
          puts "GET: "+response.uri.to_s
          response
        end

        def post uri, params = {}
          response = Net::HTTP.post_form(uri, params)
          puts "POST: "+response.uri.to_s
          response
        end
      
    end
  end
end