require 'securerandom'
module Util
  # Util::UUIDGenerator is responsible for UUID-token generation
  #
  class UUIDGenerator
    def generate
      SecureRandom.uuid
    end
  end
end
