require 'nokogiri'

module Cwc
  module Utils
    module XML
      # Returns an array of the error messages thrown in the response
      def parse_errors response
        @response ||= response
        puts "XML would be: "+response.body
        #xml_response = Nokogiri::XML(response.body)
      end
    end
  end
end