require 'cwc/api/client'

module Cwc
  module Api
    class Offices < Client
      def send
        response = request(:get, 'offices')
        puts "Offices response: "+response.to_s
        handle_response response
      end
    end
  end
end