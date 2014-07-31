require 'openssl'
require 'net/http'
require 'ansi'
require 'cwc/cwc'
require 'cwc/utils/xml'

module Cwc
  module Api
    class Client
      include Cwc::Utils::XML

      def initialize
        Cwc.validate_settings
      end

      # Sends a request to the server based in the Cwc.api_base parameter plus the path sent
      # Returns a Net::HTTPResponse
      # It allows different options for the request:
      # - params: Parameters sent as GET
      # - body: Body of the request
      # - ssl: If it is a secure request
      # - verbose: Log information into console
      def request method = :get, path = "", options = {}
        options[:api_key] = Cwc.api_key
        uri = URI(Cwc.api_url(path.to_s))
        case method.to_s.upcase
        when "GET"
          get uri, options
        when "POST"
          post uri, options
        else
          get uri, options
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
            when "401"
              raise ApiError.new("API key may be wrong. Response: 404")
            else
              raise ApiError.new("Error in the request. Response: "+response.code)
          end
        end

      private
        def get uri, options = {}
          # It is neccesary to send the API key as a GET parameter
          uri.query = URI.encode_www_form({apikey: options[:api_key]})
          puts ANSI.green("GET: "+uri.to_s) if options[:verbose]
          http = Net::HTTP::new(uri.host, uri.port)
          # Use SSL
          http.use_ssl = options[:ssl]
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          request = Net::HTTP::Get.new(uri.request_uri)
          request.content_type = "application/xml"
          http.request(request)
        end

        def post uri, options = {}
          # It is neccesary to send the API key as a GET parameter
          uri.query = URI.encode_www_form({apikey: options[:api_key]})
          puts ANSI.green("POST: "+uri.to_s) if options[:verbose]
          http = Net::HTTP::new(uri.host, uri.port)
          # Use SSL
          http.use_ssl = options[:ssl]
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          request = Net::HTTP::Post.new(uri.request_uri)
          request.content_type = "application/xml"
          request.body = options[:body]
          if options[:verbose]
            puts ANSI.magenta("--Start Body--")
            puts request.body
            puts ANSI.magenta("--End Body--")
          end
          http.request(request)
        end
      
    end
  end
end