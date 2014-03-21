require 'uuidtools'

module Cwc
  module Utils
    module Random
      def self.guid
        UUIDTools::UUID.random_create.to_s
      end
    end
  end
end