# frozen_string_literal: true

# @api public
# @since 0.1.0
class JSONRPC::Response < SmartCore::ValueObject
  # @api public
  # @since 0.1.0
  property :jsonrpc, SmartCore::Types::Variadic::Enum('2.0')

  # @api public
  # @since 0.1.0
  property :result, SmartCore::Types::Value::Hash

  # @api public
  # @since 0.1.0
  property :id, SmartCore::Types::Value::String

  # @return [Boolean]
  #
  # @api public
  # @since 0.1.0
  def error? = false

  # @return [Boolean]
  #
  # @api public
  # @since 0.1.0
  def success? = true
end
