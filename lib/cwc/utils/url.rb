module Cwc
  module Utils
    module URL
      def add_trailing_slash value
        value << '/' unless value.end_with?('/')
        value
      end
    end
  end
end