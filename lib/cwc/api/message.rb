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
        response = request(:post, Cwc.api_version+'/message', {response: 400})
        if handle_response(response)
          # Request was successful
        end
      end
    end
  end
end