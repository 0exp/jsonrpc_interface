# frozen_string_literal: true

# @api public
# @since 0.1.0
module JSONRPC::RPCObject
  module_function

  # @param result [Hash<String|Symbol,Any>]
  # @option request_id [String, NilClass]
  # @return [JSONRPC::Response, NilClass]
  #
  # @api public
  # @since 0.1.0
  def response(result = {}, request_id: nil)
    return if request_id == nil # NOTE: nil is treated as no result
    JSONRPC::Response.new(jsonrpc: '2.0', result:, id:)
  end

  # @param data [Hash<String|Symbol,Any>]
  # @option code [Integer]
  # @option message [String]
  # @option request_id [String, NilClass]
  # @return [JSONRPC::ErrorResponse]
  #
  # @api public
  # @since 0.1.0
  def error(
    data = {},
    code: JSONRPC::ERRORS[:application_error][:code],
    message: JSONRPC::ERRORS[:application_error][:message],
    request_id: nil
  )
    JSONRPC::ErrorResponse.new(
      jsonrpc: '2.0',
      error: { code:, message:, data: },
      id: request_id
    )
  end
  alias_method :application_error, :error

  # @option jsonrpc [String]
  # @option method [String]
  # @option params [Hash<String|Symbol,Any>]
  # @option id [String]
  # @return [JSONRPC::Request]
  #
  # @api public
  # @since 0.1.0
  def request(jsonrpc: '2.0', method:, params:, id:)
    JSONRPC::Request.new(jsonrpc:, method:, params:, id:)
  end

  # @option jsonrpc [String]
  # @option method [String]
  # @option params [Hash<Symbol,Any>]
  # @return [JSONRPC::Notification]
  #
  # @api public
  # @since 0.1.0
  def notification(jsonrpc: '2.0', method:, params:)
    JSONRPC::Notification.new(jsonrpc:, method:, params:)
  end

  # @param data [Hash]
  # @option request_id [String, NilClass]
  # @return [JSONRPC::ErrorResponse]
  #
  # @api public
  # @since 0.1.0
  def invalid_request_error(data = {}, request_id: nil)
    error(
      data,
      code: JSONRPC::ERRORS[:invalid_request][:code],
      message: JSONRPC::ERRORS[:invalid_reqeust][:message],
      request_id:
    )
  end

  # @return [JSONRPC::ErrorResponse]
  #
  # @api public
  # @since 0.1.0
  def parse_error
    error(
      code: JSONRPC::ERRORS[:parse_error][:code],
      message: JSONRPC::ERRORS[:parse_error][:message]
    )
  end

  # @option request_id [String, NilClass]
  # @return [JSONRPC::ErrorResponse]
  #
  # @api public
  # @since 0.1.0
  def jsonrpc_specification_violation_error(request_id: nil)
    error(
      code: JSONRPC::ERRORS[:jsonrpc_specification_violation][:code],
      message: JSONRPC::ERRORS[:jsonrpc_specification_violation][:message],
      request_id:
    )
  end

  # @option request_id [String, NilClass]
  # @return [JSONRPC::ErrorResponse]
  #
  # @api public
  # @since 0.1.0
  def method_not_found_error(request_id: nil)
    error(
      code: JSONRPC::ERRORS[:method_not_found][:code],
      message: JSONRPC::ERRORS[:method_not_found][:message],
      request_id:
    )
  end

  # @param data [Hash<String|Symbol,Any>]
  # @option request_id [String, NilClass]
  # @return [JSONRPC::ErrorResponse]
  #
  # @api public
  # @since 0.1.0
  def invalid_params_error(data = {}, request_id: nil)
    error(
      data,
      code: JSONRPC::ERRORS[:invalid_params][:code],
      message: JSONRPC::ERRORS[:invalid_params][:message],
      request_id:
    )
  end

  # @param error_codes [*Array<String,Symbol>]
  # @option error_context [Hash<String|Symbol,Any>]
  # @option request_id [String, NilClass]
  # @return [JSONRPC::ErrorResponse]
  #
  # @api public
  # @since 0.1.0
  def internal_error(*error_codes, error_context: {}, request_id: nil)
    error(
      { error_codes:, error_context: },
      code: JSONRPC::ERRORS[:internal_error][:code],
      message: JSONRPC::ERRORS[:internal_error][:message],
      request_id:
    )
  end

  # @param exception [Exception]
  # @option request_id [String, NilClass]
  # @return [JSONRPC::ErrorResponse]
  #
  # @api public
  # @since 0.1.0
  def detailed_internal_error(exception, request_id: nil)
    internal_error(
      error_context: {
        error_class: exception.class,
        error_message: exception.message,
        error_backtrace: exception.backtrace,
        error_object: exception
      },
      request_id:
    )
  end
end
