require 'cwc/api/client'

module Cwc
  module Api
    class Offices < Client
      def send
        response = request(:get, 'offices')
        if handle_response response
          # Request was successful
          puts "Response:\n"+ANSI.yellow(response.body)
          true
        end
      end
    end
  end
end