require 'cwc/api/client'

module Cwc
  module Api
    class Offices < Client
      @@offices_url = 'offices'

      def send! options={}
        options[:ssl] = true unless options.has_key? :ssl
        options[:verbose] = true unless options.has_key? :verbose
        response = request(:get, @@offices_url, options)
        if handle_response(response, options[:verbose])
          # Request was successful
          puts "Response:\n"+ANSI.yellow(response.body) if options[:verbose]
          response.code
        end
      end
    end
  end
end