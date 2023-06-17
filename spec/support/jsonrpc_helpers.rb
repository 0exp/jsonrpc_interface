# frozen_string_literal: true

module SpecSupport
  module JSONRPCHelpers
    def rand_request_id
      SecureRandom.uuid
    end
  end
end
