require 'net/http'
require 'ansi'
require 'cwc/cwc'
require 'cwc/utils/xml'
require 'cwc/utils/parameters'

module Cwc
  module Api
    class Client < Cwc::Utils::Parameters
      include Cwc::Utils::XML

      def initialize
        Cwc.validate_settings
      end

      def request method, path, params_or_data = nil, ssl = true, verbose = false
        uri = URI(Cwc.api_url(path.to_s))
        case method.to_s.upcase
        when "GET"
          get uri, params_or_data, ssl, verbose
        when "POST"
          post uri, params_or_data, ssl, verbose
        else
          get uri, params_or_data, ssl, verbose
        end
      end

      protected
        # Handles the response from the request done to the API
        def handle_response response, verbose = true
          case response.code
            when "200"
              puts ANSI.green("OK: 200") if verbose
              response
            when "400"
              raise ApiError.new("An error occurred with the request. Response: 400", response)
            when "404"
              raise ApiError.new("Command not found. Response: 404")
            else
              raise ApiError.new("Error in the request. Response: "+response.code)
          end
        end

      private
        def get uri, params = {}, ssl = true, verbose = false
          params = {} if params.nil?
          # It is neccesary to send the API key as a GET parameter
          params[:apikey] = Cwc.api_key
          uri.query = URI.encode_www_form(params)
          puts ANSI.green("GET: "+uri.to_s) if verbose
          http = Net::HTTP::new(uri.host, uri.port)
          # Use SSL
          http.use_ssl = ssl
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          request = Net::HTTP::Get.new(uri.request_uri)
          request.content_type = "application/xml"
          http.request(request)
        end

        def post uri, data = nil, ssl = true, verbose = false
          # It is neccesary to send the API key as a GET parameter
          uri.query = URI.encode_www_form({apikey: Cwc.api_key})
          puts ANSI.green("POST: "+uri.to_s) if verbose
          http = Net::HTTP::new(uri.host, uri.port)
          # Use SSL
          http.use_ssl = ssl
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          request = Net::HTTP::Post.new(uri.request_uri)
          request.content_type = "application/xml"
          request.body = data
          if verbose
            puts ANSI.magenta("--Start Body--")
            puts request.body
            puts ANSI.magenta("--End Body--")
          end
          http.request(request)
        end
      
    end
  end
end