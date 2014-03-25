require 'cwc/api/client'

module Cwc
  module Api
    class Offices < Client
      def send ssl = true, verbose = false
        response = request(:get, 'offices', nil, ssl, verbose)
        if handle_response response, verbose
          # Request was successful
          puts "Response:\n"+ANSI.yellow(response.body) if verbose
          true
        end
      end
    end
  end
end