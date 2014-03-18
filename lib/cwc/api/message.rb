require 'cwc/api/client'

module Cwc
  module Api
    class Message < Client
      def initialize(data={}, autosend = false)
        @data = data
        if autosend === true
          self.send
        end
      end

      def send
        request(:post, Cwc.api_version+'/message')
      end
    end
  end
end