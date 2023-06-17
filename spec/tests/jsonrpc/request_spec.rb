# frozen_string_literal: true

RSpec.describe JSONRPC::Request do
  specify 'value object inteface' do
    request_id = rand_request_id

    request = described_class.new(
      jsonrpc: '2.0',
      method: 'any.method',
      params: { any: 'parameter' },
      id: request_id
    )

    aggregate_failures 'interface' do
      expect(request.jsonrpc).to eq('2.0')
      expect(request.method).to eq('any.method')
      expect(request.params).to eq({ any: 'parameter' })
      expect(request.id).to eq(request_id)
    end
  end
end
