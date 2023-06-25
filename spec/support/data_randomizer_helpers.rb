# frozen_string_literal: true

module SpecSupport::DataRandomizerHelpers
  CHARS = ('a'..'z').to_a.freeze
  TYPE_LIST = [String, Integer, Float, Array, Hash].freeze

  def gen_array = []
  def gen_string_array = Array.new(rand(1..10)) { gen_string }
  def gen_uuid = SecureRandom.uuid
  def gen_float = rand(1.0..10.0).to_f
  def gen_integer = rand(1..10)
  def gen_string = CHARS.dup.tap(&:shuffle!).slice!(0, rand(1..5)).join

  def gen_hash
    length = rand(1..4)

    {}.tap do |result|
      length.times do
        type = TYPE_LIST.sample
        key = gen_string.to_sym
        value = gen_value(type)

        result[key] = value
      end
    end
  end

  def gen_value(type)
    case
    when type == String then gen_string
    when type == Integer then gen_integer
    when type == Float then gen_float
    when type == Array then gen_array
    when type == Hash then gen_hash
    else
      raise ArgumentError, 'Unsupported type'
    end
  end
end
