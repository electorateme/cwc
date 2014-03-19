module Cwc
  class CwcError < StandardError
    attr_reader :message
    attr_reader :http_status
    attr_reader :http_body
    attr_reader :json_body

    def initialize(message=nil)
      @message = message
    end

    def to_s
      ANSI.red(@message)
    end
  end
end