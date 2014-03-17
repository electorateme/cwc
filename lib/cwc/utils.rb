module Cwc
  module Utils
    def add_trailing_slash value
      value << '/' unless value.end_with?('/')
    end
  end
end