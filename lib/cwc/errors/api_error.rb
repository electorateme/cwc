require 'cwc/utils/xml'

module Cwc
  class ApiError < CwcError
    include Cwc::Utils::XML

    def initialize(message=nil, response=nil)
      super(message)
      @response = response unless response.nil?
    end

    def to_s
      result = super()+"\n"
      # Parse errors
      if @response
        errors = parse_errors @response
        if errors.size > 0
          result += ANSI.red(errors.join("\n"))
        end
        result += ANSI.red("\nResponse:\n")
        result += ANSI.red(@response.body)
      end
      result
    end

    def status_code
      if @response
        @response.code
      end
    end

    def cwc_response
      if @response
        @response.body
      end
    end

    def errors
      if @response
        parse_errors @response
      end
    end
  end
end