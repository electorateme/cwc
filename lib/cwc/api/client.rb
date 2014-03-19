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

      protected
        def request method, path, params_or_data = nil, verbose = false
          uri = URI(Cwc.api_url(path.to_s))
          case method.to_s.upcase
          when "GET"
            get uri, params_or_data
          when "POST"
            post uri, params_or_data, verbose
          else
            get uri, params_or_data
          end
        end

        # Handles the response from the request done to the API
        def handle_response response
          case response.code
            when "200"
              puts ANSI.green("OK: 200")
              response
            when "400"
              errors = parse_errors(response)
              raise ApiError.new("There was an error with the request with the following errors:\n"+errors.join("\n")+"\nResponse: 400\nBody:\n"+response.body)
            when "404"
              raise ApiError.new("Command not found. Response: 404")
            else
              raise ApiError.new("Error in the request. Response: "+response.code)
          end
        end

      private
        def get uri, params = {}
          params = {} if params.nil?
          # It is neccesary to send the API key as a GET parameter
          params[:apikey] = Cwc.api_key
          uri.query = URI.encode_www_form(params)
          puts ANSI.green("GET: "+uri.to_s)
          http = Net::HTTP::new(uri.host, uri.port)
          # Use SSL
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          request = Net::HTTP::Get.new(uri.request_uri)
          request.content_type = "application/xml"
          http.request(request)
        end

        def post uri, data = nil, verbose = false
          # It is neccesary to send the API key as a GET parameter
          uri.query = URI.encode_www_form({apikey: Cwc.api_key})
          puts ANSI.green("POST: "+uri.to_s)
          http = Net::HTTP::new(uri.host, uri.port)
          # Use SSL
          http.use_ssl = true
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