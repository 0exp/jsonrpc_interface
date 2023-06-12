# frozen_string_literal: true

# @api public
# @since 0.1.0
class JSONRPC::Notification < SmartCore::ValueObject
  # @return [Class<SmartCore::Schema>]
  #
  # @api public
  # @since 0.1.0
  class Schema < SmartCore::Schema
    schema do
      required(:jsonrpc).type(:string).filled
      required(:method).type(:string).filled
      required(:params).type(:hash).filled
    end
  end

  # @api public
  # @since 0.1.0
  property :jsonrpc, SmartCore::Types::Variadic::Enum('2.0')

  # @api public
  # @since 0.1.0
  property :method, SmartCore::Types::Value::String

  # @api public
  # @since 0.1.0
  property :params, SmartCore::Types::Value::Hash

  # @return [Boolean]
  #
  # @api public
  # @since 0.1.0
  def notification? = true

  # @return [Boolean]
  #
  # @api public
  # @since 0.1.0
  def request? = false
end
