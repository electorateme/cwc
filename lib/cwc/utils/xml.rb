require 'nokogiri'

module Cwc
  module Utils
    module XML
      # Returns an array of the error messages thrown in the response
      def parse_errors response
        @response ||= response
        @xml_response ||= Nokogiri::XML(response.body)
        return @xml_response.css("Error").map{ |error| error.text }
      end
    end
  end
end