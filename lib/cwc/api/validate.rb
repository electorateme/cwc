require 'cwc/api/client'

module Cwc
  module Api
    class Validate < Client
      def send
        request(:post, Cwc.api_version+'/validate')
      end
    end
  end
end