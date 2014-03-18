module Cwc
  module Utils
    module URL
      def add_trailing_slash value
        value << '/' unless value.end_with?('/')
      end
    end
  end
end