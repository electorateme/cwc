require 'cwc/utils/xml'

module Cwc
  class ApiError < CwcError
    include Cwc::Utils::XML

    def initialize(message=nil, response=nil)
      super(message)
      @response = response unless response.nil?
    end

    def to_s
      result = super()
      # Parse errors
      if @response
        errors = parse_errors @response
        if errors.size > 0
          result += ANSI.red(errors.join("\n"))
          result += ANSI.red("Body of the response:")
          result += ANSI.red(@response.body)
        end
      end
      result
    end
  end
end