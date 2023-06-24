# frozen_string_literal: true

RSpec.describe JSONRPC::Request do
  specify 'value object inteface' do
    request_id = rand_jrpc_request_id
    params = rand_jrpc_params
    method = rand_jrpc_method

    request = described_class.new(jsonrpc: '2.0', method:, params:, id: request_id)

    aggregate_failures 'interface' do
      expect(request.jsonrpc).to eq('2.0')
      expect(request.method).to eq(method)
      expect(request.params).to eq(params)
      expect(request.id).to eq(request_id)
    end
  end
end
