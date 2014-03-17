require 'cwc/api/client'

module Cwc
  module Api
    class Message
      extend Cwc::Api::Client
      def initialize(data={}, autosend = false)
        @data = data
        if autosend
          self.send
        end
      end

      def send
        
      end
    end
  end
end