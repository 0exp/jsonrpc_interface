# frozen_string_literal: true

require 'smart_core/types'
require 'smart_core/schema'
require 'smart_core/value-object'

# @api public
# @since 0.1.0
module JSONRPC
  require_relative 'jsonrpc/version'
  require_relative 'jsonrpc/request'
  require_relative 'jsonrpc/notification'
  require_relative 'jsonrpc/response'
  require_relative 'jsonrpc/error_response'
  require_relative 'jsonrpc/rpc_object'

  # @return [Hash<Symbol,Hash<String|Integer>>]
  #
  # @api public
  # @since 0.1.0
  ERRORS = {
    parse_error: {
      code: -32_700,
      message: 'Parse Error'
    },
    invalid_reqeust: {
      code: -32_600,
      message: 'Invalid Request'
    },
    method_not_found: {
      code: -32_601,
      message: 'Method Not Found'
    },
    invalid_params: {
      code: -32_602,
      message: 'Invalid Params'
    },
    internal_error: {
      code: -32_603,
      message: 'Internal Error'
    },
    unauthorized: {
      code: -33_001,
      message: 'Unauthorized'
    },
    application_error: {
      code: -33_002,
      message: 'Application Error'
    },
    jsonrpc_specification_violation: {
      code: -33_003,
      message: 'JSONRPC Specification Violation'
    }
  }.freeze
end
