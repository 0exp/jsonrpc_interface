# JSONRPC Interface

- [Installation](#installation)
- [Usage](#usage)
- [Development](#development)
- [License](#license)
- [Authors](#authors)

## Installation

```ruby
gem 'jsonrpc_interface'
```

```shell
bundle install
# --- or ---
gem install jsonrpc_interface
```

```ruby
require 'jsonrpc_interface'
```

## Usage

- [JSONRPC::ERRORS](#jsonrpcerrors)
- [JSONRPC::Request](#jsonrpcrequest)
  - [JSONRPC::Request::Schema](#jsonrpcrequestschema)
- [JSONRPC::Notification](#jsonrpcnotification)
  - [JSONRPC::Notification::Schema](#jsonrpcnotificationschema)
- [JSONRPC::Response](#jsonrpcresponse)
- [JSONRPC::ErrorResponse](#jsonrpcerrorresponse)
  - [JSONRPC::ErrorResponse::Schema](#jsonrpcerrorresponseschema)
- [JSONRPC::RPCObject](#jsonrpcrpcobject)
  - [.response](#response)
  - [.request](#request)
  - [.notification](#notification)
  - [.invalid_request_error](#invalid_request_error)
  - [.parse_error](#parse_error)
  - [.jsonrpc_specification_violation_error](#jsonrpc_specification_violation_error)
  - [.method_not_found_error](#method_not_found_error)
  - [.invalid_params_error](#invalid_params_error)
  - [.internal_error](#internal_error)
  - [.detailed_internal_error](#detailed_internal_error)

### JSONRPC::ERRORS

```ruby
JSONRPC::ERRORS
# =>
{
  parse_error: { code: -32_700, message: 'Parse Error' },
  invalid_request: { code: -32_600, message: 'Invalid Request' },
  method_not_found: { code: -32_601, message: 'Method Not Found' },
  invalid_params: { code: -32_602, message: 'Invalid Params' },
  internal_error: { code: -32_603, message: 'Internal Error' },
  unauthorized: { code: -33_001, message: 'Unauthorized' },
  application_error: { code: -33_002, message: 'Application Error' },
  jsonrpc_specification_violation: { code: -33_003, message: 'JSONRPC Specification Violation' }
}
```
### JSONRPC::Request

```ruby
JSONRPC::Request
JSONRPC::Request.new(jsonrpc: '2.0', method: 'some.method', params: { some: 'params' }, id: 'sOmEiD')
JSONRPC::Request#jsonrpc (String)
JSONRPC::Request#method (String)
JSONRPC::Request#params (Hash)
JSONRPC::Request#id (String)
```

### JSONRPC::Request::Schema

```ruby
schema do
  required(:jsonrpc).type(:string).filled
  required(:method).type(:string).filled
  required(:params).type(:hash).filled
  required(:id).type(:string).filled
end
```

### JSONRPC::Notification

```ruby
JSONRPC::Notification
JSONRPC::Notification.new(jsonrpc: '2.0', method: 'some.method', params: { some: 'params' })
JSONRPC::Notification#jsonrpc (String)
JSONRPC::Notification#method (String)
JSONRPC::Notification#params (Hash)
```

### JSONRPC::Notification::Schema

```ruby
schema do
  required(:jsonrpc).type(:string).filled
  required(:method).type(:string).filled
  required(:params).type(:hash).filled
end
```

### JSONRPC::Response

```ruby
JSONRPC::Response
JSONRPC::Response.new(jsonrpc: '2.0', result: { some: 'result' }, id: 'sOmEiD')
JSONRPC::Response#jsonrpc (String)
JSONRPC::Response#result (Hash)
JSONRPC::Response#id (String)
```

### JSONRPC::ErrorResponse

```ruby
JSONRPC::ErrorResponse
JSONRPC::ErrorResponse.new(jsonrpc: '2.0', method: 'some.method', params: { some: 'params' }, id: nil)
JSONRPC::ErrorResponse.new(jsonrpc: '2.0', method: 'some.method', params: { some: 'params' }, id: 'sOmEiD')
JSONRPC::ErrorResponse#jsonrpc (String)
JSONRPC::ErrorResponse#error (Hash)
JSONRPC::ErrorResponse#id (String, NilClass)

JSONRPC::ErrorResponse#error
# signature =>
{ code: Integer, message: String, data: Hash }
```

### JSONRPC::ErrorResponse::Schema

```ruby
schema do
  required(:code).type(:integer).filled
  required(:message).type(:string).filled
  required(:data).type(:hash).filled
end
```

### JSONRPC::RPCObject

- [.response](#response)
- [.request](#request)
- [.notification](#notification)
- [.invalid_request_error](#invalid_request_error)
- [.parse_error](#parse_error)
- [.jsonrpc_specification_violation_error](#jsonrpc_specification_violation_error)
- [.method_not_found_error](#method_not_found_error)
- [.invalid_params_error](#invalid_params_error)
- [.internal_error](#internal_error)
- [.detailed_internal_error](#detailed_internal_error)

### .response

```ruby
JSONRPC::RPCObject.response(
  { some: 'data' },
  request_id: SecureRandom.uuid
) # => JSONRPC::Response
```

### .request


```ruby
JSONRPC::RPCObject.request(
  method: 'some.method',
  params: { some: 'params' },
  request_id: SecureRandom.uuid
) # => JSONRPC::Request
```

### .notification

```ruby
JSONRPC::RPCObject.notification(
  method: 'some.method',
  params: { some: 'params' }
) # => JSONRPC::Notification
```

### .invalid_request_error

```ruby
JSONRPC::RPCObject.invalid_request_error({ some: 'data' })
JSONRPC::RPCObject.invalid_request_error({ some: 'data' }, request_id: SecureRandom.uuid)

JSONRPC::ErrorResponse#error
# error hash signature =>
{ code: -32_600, message: 'Invalid Request', data: { some: 'data' } }
```

### .parse_error

```ruby
JSONRPC::RPCObject.parse_error

JSONRPC::ErrorResponse#error
# error hash signature =>
{ code: -32_700, message: 'Parse Error', data: {} }
```

### .jsonrpc_specification_violation_error

```ruby
JSONRPC::RPCObject.jsonrpc_specification_violation_error
JSONRPC::RPCObject.jsonrpc_specification_violation_error(request_id: SecureRandom.uuid)

JSONRPC::ErrorResponse#error
# error hash signature =>
{ code: -33_003, message: 'JSONRPC Specification Violation', data: {} }
```

### .method_not_found_error

```ruby
JSONRPC::RPCObject.method_not_found_error
JSONRPC::RPCObject.method_not_found_error(request_id: SecureRandom.uuid)

JSONRPC::ErrorResponse#error
# error hash signature =>
{ code: -32_601, message: 'Method Not Found', data: {} }
```

### .invalid_params_error

```ruby
JSONRPC::RPCObject.invalid_params_error
JSONRPC::RPCObject.invalid_params_error(request_id: SecureRandom.uuid)

JSONRPC::ErrorResponse#error
# error hash signature =>
{ code: -32_602, message: 'Invalid Params', data: {} }
```

### .internal_error

```ruby
JSONRPC::RPCObject.internal_error('some', 'error', 'code', error_context: { some: 'context' })
JSONRPC::RPCObject.internal_error('some', 'error', 'code', error_context: { some: 'context' }, request_id: SecureRandom.uuid)
JSONRPC::RPCObject.internal_error
JSONRPC::RPCObject.internal_error(request_id: SecureRandom.uuid)

JSONRPC::ErrorResponse#error
# error hash signature =>
{
  code: -32_603,
  message: 'Internal Error',
  data: {
    error_codes: ['some', 'error', 'code'],
    error_cotnext: { some: 'context' }
  }
}
```

### .detailed_internal_error

```ruby
JSONRPC::RPCObject.detailed_internal_error(exception)
JSONRPC::RPCObject.detailed_internal_error(exception, request_id: SecureRandom.uuid)

JSONRPC::ErrorResponse#error
# signature =>
{
  code: -32_603,
  message: 'Internal Error',
  data: {
    error_codes: [],
    error_cotnext: {
      error_class: # => exception.class,
      error_message: # => exception.message,
      error_backtrace: # => exception.backtrace,
      error_object: # => exception
    }
  }
}
```

## Development

- full build (`steep` => `rubocop` => `rspec`)

```shell
bundle exec rake
```

- code style check (`rubocop`):

```shell
bundle exec rake rubocop
```

- type validation check (`steep`):

```shell
bundle exec rake steep
```

- tests (`rspec`):

```shell
bundle exec rake rspec
```

## License

Released under MIT License.

## Authors

[Rustam Ibragimov](https://github.com/0exp)
