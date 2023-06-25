# frozen_string_literal: true

RSpec.describe 'JRPC Attribute Schema' do
  describe 'request schema' do
    let(:schema) { JSONRPC::Request::Schema }

    specify 'valid structure' do
      expect(schema.valid?({
        jsonrpc: gen_string,
        method: gen_string,
        params: gen_hash,
        id: gen_string
      })).to eq(true)
    end

    specify 'jsonrpc should be a string' do
      expect(schema.valid?({
        jsonrpc: nil,
        method: gen_string,
        params: gen_hash,
        id: gen_string
      })).to eq(false)
    end

    specify 'method should be a string' do
      expect(schema.valid?({
        jsonrpc: gen_string,
        method: nil,
        params: gen_hash,
        id: gen_string
      })).to eq(false)
    end

    specify 'params should be a hash' do
      expect(schema.valid?({
        jsonrpc: gen_string,
        method: gen_string,
        params: nil,
        id: gen_string
      })).to eq(false)
    end

    specify 'id should be a string' do
      expect(schema.valid?({
        jsonrpc: gen_string,
        method: gen_string,
        params: gen_hash,
        id: nil
      })).to eq(false)
    end
  end

  describe 'notification schema' do
    let(:schema) { JSONRPC::Notification::Schema }

    specify 'valid structure' do
      expect(schema.valid?({
        jsonrpc: gen_string,
        method: gen_string,
        params: gen_hash
      })).to eq(true)
    end

    specify 'jsonrpc should be a string' do
      expect(schema.valid?({
        jsonrpc: nil,
        method: gen_string,
        params: gen_hash
      })).to eq(false)
    end

    specify 'method should be a string' do
      expect(schema.valid?({
        jsonrpc: gen_string,
        method: nil,
        params: gen_hash
      })).to eq(false)
    end

    specify 'params should be a hash' do
      expect(schema.valid?({
        jsonrpc: gen_string,
        method: gen_string,
        params: nil
      })).to eq(false)
    end
  end

  describe 'error schema' do
    let(:schema) { JSONRPC::ErrorResponse::ErrorSchema }

    specify 'valid structure' do
      expect(schema.valid?({
        code: gen_integer,
        message: gen_string,
        data: gen_hash
      })).to eq(true)
    end

    specify 'code should be a integer' do
      expect(schema.valid?({
        code: nil,
        message: gen_string,
        data: gen_hash
      })).to eq(false)
    end

    specify 'message should be a string' do
      expect(schema.valid?({
        code: gen_integer,
        message: nil,
        data: gen_hash
      })).to eq(false)
    end

    specify 'data should be a hash' do
      expect(schema.valid?({
        code: gen_integer,
        message: gen_string,
        data: nil
      })).to eq(false)
    end
  end
end
