require 'cwc/api/client'

module Cwc
  module Api
    class Message < Client
      def initialize(data={}, autosend = false)
        super()
        @data = data
        if autosend === true
          self.send
        end
      end

      def send
        # Prepare data for request
        request_data = parse_xml
        response = request(:post, Cwc.api_version+'/message', request_data)
        if handle_response(response)
          # Request was successful
          puts "Response:\n"+ANSI.yellow(response.body)
          true
        end
      end

      def validate verbose=false
        # Prepare data for request
        request_data = parse_xml
        response = request(:post, Cwc.api_version+'/validate', request_data, verbose)
        if handle_response(response)
          # Request was successful
          puts "Response:\n"+ANSI.yellow(response.body)
          true
        end
      end
    end
  end
end