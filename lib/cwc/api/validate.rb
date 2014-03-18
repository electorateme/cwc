require 'cwc/api/client'

module Cwc
  module Api
    class Validate < Client
      def send
        response = request(:post, Cwc.api_version+'/validate')
        if handle_response(response)
          # Request was successful
          puts "Response:\n"+ANSI.yellow(response.body)
          true
        end
      end
    end
  end
end