# frozen_string_literal: true

RSpec.describe JSONRPC::RPCObject do
  describe 'response' do
    specify 'common usage' do
      result = gen_hash
      request_id = rand_jrpc_request_id
      response = described_class.response(result, request_id:)

      expect(response).to be_a(JSONRPC::Response)
      expect(response.id).to eq(request_id)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.result).to eq(result)
    end

    specify 'no id - no response' do
      result = gen_hash
      response = described_class.response(result, request_id: nil)
      expect(response).to eq(nil)
    end

    specify 'no id by default' do
      result = gen_hash
      response = described_class.response(result)
      expect(response).to eq(nil)
    end

    specify 'result is empty hash by default' do
      request_id = rand_jrpc_request_id
      response = described_class.response(request_id:)

      expect(response).to be_a(JSONRPC::Response)
      expect(response.result).to eq({})
      expect(response.jsonrpc).to eq('2.0')
    end
  end

  describe 'error / application_error' do
    shared_examples 'method behavior' do |object_method|
      specify 'common usage' do
        data = gen_hash
        request_id = rand_jrpc_request_id

        response = described_class.public_send(object_method, data, request_id:)

        expect(response).to be_a(JSONRPC::ErrorResponse)
        expect(response.jsonrpc).to eq('2.0')
        expect(response.id).to eq(request_id)
        expect(response.error).to match(code: -33_002, message: 'Application Error', data:)
      end

      specify 'no id - id is nil' do
        data = gen_hash
        response = described_class.public_send(object_method, data)

        expect(response).to be_a(JSONRPC::ErrorResponse)
        expect(response.id).to eq(nil)
        expect(response.jsonrpc).to eq('2.0')
        expect(response.error).to match(code: -33_002, message: 'Application Error', data:)
      end

      specify 'no data - data is empty' do
        response = described_class.public_send(object_method)

        expect(response).to be_a(JSONRPC::ErrorResponse)
        expect(response.id).to eq(nil)
        expect(response.jsonrpc).to eq('2.0')
        expect(response.error).to match(code: -33_002, message: 'Application Error', data: {})
      end

      specify 'custom code and message behavior' do
        code = gen_integer
        message = gen_string
        response = described_class.public_send(object_method, code:, message:)

        expect(response).to be_a(JSONRPC::ErrorResponse)
        expect(response.jsonrpc).to eq('2.0')
        expect(response.error).to match(code:, message:, data: {})
      end
    end

    it_behaves_like 'method behavior', :error
    it_behaves_like 'method behavior', :application_error
  end

  describe 'request' do
    specify 'common usage' do
      method = rand_jrpc_method
      params = rand_jrpc_params
      request_id = rand_jrpc_request_id

      request = described_class.request(method:, params:, id: request_id)

      expect(request).to be_a(JSONRPC::Request)
      expect(request.params).to eq(params)
      expect(request.id).to eq(request_id)
      expect(request.jsonrpc).to eq('2.0')
    end
  end

  describe 'notification' do
    specify 'common usage' do
      method = rand_jrpc_method
      params = rand_jrpc_params

      notification = described_class.notification(method:, params:)

      expect(notification).to be_a(JSONRPC::Notification)
      expect(notification.params).to eq(params)
      expect(notification.jsonrpc).to eq('2.0')
    end
  end

  describe 'ivnalid_request_error' do
    specify 'common usage' do
      data = gen_hash
      request_id = rand_jrpc_request_id

      response = described_class.invalid_request_error(data, request_id:)

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(request_id)
      expect(response.error).to match(code: -32_600, message: 'Invalid Request', data:)
    end

    specify 'no id - id is nil' do
      data = gen_hash
      response = described_class.invalid_request_error(data)

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(nil)
      expect(response.error).to match(code: -32_600, message: 'Invalid Request', data:)
    end

    specify 'no data - empty data' do
      response = described_class.invalid_request_error

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(nil)
      expect(response.error).to match(code: -32_600, message: 'Invalid Request', data: {})
    end
  end

  describe 'parse_error' do
    specify 'common usage' do
      response = described_class.parse_error

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(nil)
      expect(response.error).to match(code: -32_700, message: 'Parse Error', data: {})
    end
  end

  describe 'jsonrpc_specification_violation_error' do
    specify 'common usage' do
      request_id = rand_jrpc_request_id
      response = described_class.jsonrpc_specification_violation_error(request_id:)

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(request_id)
      expect(response.error).to match(
        code: -33_003, message: 'JSONRPC Specification Violation', data: {}
      )
    end

    specify 'no id - id is nil' do
      response = described_class.jsonrpc_specification_violation_error

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(nil)
      expect(response.error).to match(
        code: -33_003, message: 'JSONRPC Specification Violation', data: {}
      )
    end
  end

  describe 'method_not_found_error' do
    specify 'common usage' do
      request_id = rand_jrpc_request_id
      response = described_class.method_not_found_error(request_id:)

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(request_id)
      expect(response.error).to match(code: -32_601, message: 'Method Not Found', data: {})
    end

    specify 'no id - id is nil' do
      response = described_class.method_not_found_error

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(nil)
      expect(response.error).to match(code: -32_601, message: 'Method Not Found', data: {})
    end
  end

  describe 'invalid_params_error' do
    specify 'common usage' do
      data = gen_hash
      request_id = rand_jrpc_request_id

      response = described_class.invalid_params_error(data, request_id:)

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(request_id)
      expect(response.error).to match(code: -32_602, message: 'Invalid Params', data:)
    end

    specify 'no id - id is nil' do
      data = gen_hash
      response = described_class.invalid_params_error(data)

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(nil)
      expect(response.error).to match(code: -32_602, message: 'Invalid Params', data:)
    end

    specify 'no data - empty data' do
      response = described_class.invalid_params_error

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(nil)
      expect(response.error).to match(code: -32_602, message: 'Invalid Params', data: {})
    end
  end

  describe 'internal_error' do
    specify 'common usage' do
      error_codes = gen_string_array
      error_context = gen_hash
      request_id = rand_jrpc_request_id

      response = described_class.internal_error(*error_codes, error_context:, request_id:)

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(request_id)
      expect(response.error).to match(
        code: -32_603,
        message: 'Internal Error',
        data: match({ error_codes:, error_context: })
      )
    end

    specify 'no codes / no context / no request_id => empty condes, empty context, nil id' do
      response = described_class.internal_error

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(nil)
      expect(response.error).to match(
        code: -32_603,
        message: 'Internal Error',
        data: match({ error_codes: [], error_context: {} })
      )
    end
  end

  describe 'detailed_internal_error' do
    specify 'common usage' do
      error_message = gen_string
      error_backtrace = gen_string_array
      error_class = Class.new(StandardError)
      error = error_class.new(error_message)
      error.set_backtrace(error_backtrace)
      request_id = rand_jrpc_request_id

      response = described_class.detailed_internal_error(error, request_id:)

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(request_id)
      expect(response.error).to match({
        code: -32_603,
        message: 'Internal Error',
        data: match({
          error_codes: [],
          error_context: match({
            error_class: error_class,
            error_message: error_message,
            error_backtrace: error_backtrace,
            error_object: error
          })
        })
      })
    end

    specify 'no request id - id is nil' do
      error_message = gen_string
      error_backtrace = gen_string_array
      error_class = Class.new(StandardError)
      error = error_class.new(error_message)
      error.set_backtrace(error_backtrace)

      response = described_class.detailed_internal_error(error)

      expect(response).to be_a(JSONRPC::ErrorResponse)
      expect(response.jsonrpc).to eq('2.0')
      expect(response.id).to eq(nil)
      expect(response.error).to match({
        code: -32_603,
        message: 'Internal Error',
        data: match({
          error_codes: [],
          error_context: match({
            error_class: error_class,
            error_message: error_message,
            error_backtrace: error_backtrace,
            error_object: error
          })
        })
      })
    end
  end
end
