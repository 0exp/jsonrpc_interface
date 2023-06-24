# frozen_string_literal: true

module SpecSupport::JSONRPCHelpers
  def rand_jrpc_method = "#{gen_string}.#{gen_string}"
  def rand_jrpc_params = gen_hash
  def rand_jrpc_request_id = gen_uuid
end
