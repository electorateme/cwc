require 'cwc/utils/xml'

module Cwc
  class ApiError < CwcError
    include Cwc::Utils::XML

    def initialize message=nil, response=nil
      super(message)
      @response = response unless response.nil?
    end

    def to_s
      ANSI.red(@message)
      # Parse errors
      if @response
        errors = parse_errors @response
        if errors.size > 0
          puts ANSI.red(errors.join("\n"))
          puts ANSI.red("Body of the response:")
          puts ANSI.red(@response.body)
        end
      end
    end
  end
end