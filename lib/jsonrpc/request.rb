# frozen_string_literal: true

# @api public
# @since 0.1.0
class JSONRPC::Request < SmartCore::ValueObject
  # @return [SmartCore::Schema]
  #
  # @api public
  # @since 0.1.0
  Schema = Class.new(SmartCore::Schema) do
    schema do
      required(:jsonrpc).type(:string).filled
      required(:method).type(:string).filled
      required(:params).type(:hash).filled
      required(:id).type(:string).filled
    end
  end.new

  # @api public
  # @since 0.1.0
  property :jsonrpc, SmartCore::Types::Variadic::Enum('2.0')

  # @api public
  # @since 0.1.0
  property :method, SmartCore::Types::Value::String

  # @api public
  # @since 0.1.0
  property :params, SmartCore::Types::Value::Hash

  # @api public
  # @since 0.1.0
  property :id, SmartCore::Types::Value::String

  # @return [Boolean]
  #
  # @api public
  # @since 0.1.0
  def notification? = false

  # @return [Boolean]
  #
  # @api public
  # @since 0.1.0
  def request? = true
end
