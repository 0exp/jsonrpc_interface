# frozen_string_literal: true

RSpec.describe 'Gem Version' do
  it('has a version') { expect(JSONRPC::VERSION).not_to be(nil) }
end
