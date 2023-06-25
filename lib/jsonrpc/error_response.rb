# frozen_string_literal: true

# @api public
# @since 0.1.0
class JSONRPC::ErrorResponse < SmartCore::ValueObject
  # @return [SmartCore::Schema]
  #
  # @api public
  # @since 0.1.0
  ErrorSchema = Class.new(SmartCore::Schema) do
    schema do
      required(:code).type(:integer).filled
      required(:message).type(:string).filled
      required(:data).type(:hash).filled
    end
  end.new

  # @api public
  # @since 0.1.0
  SmartCore::Types::Value.define_type(:JSONRPCErrorSchema) do |type|
    type.define_checker { |value| ErrorSchema.valid?(value) }
  end

  # @api public
  # @since 0.1.0
  property :jsonrpc, SmartCore::Types::Variadic::Enum('2.0')

  # @api public
  # @since 0.1.0
  property :error, SmartCore::Types::Value::JSONRPCErrorSchema

  # @api public
  # @since 0.1.0
  property :id, SmartCore::Types::Value::String.nilable

  # @return [Boolean]
  #
  # @api public
  # @since 0.1.0
  def error? = true

  # @return [Boolean]
  #
  # @api public
  # @since 0.1.0
  def success? = false
end
