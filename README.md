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

- [JSONRPC::ErrorResponse](#jsonrpcerrorresponse)
- [JSONRPC::Response](#jsonrpcresponse)
- [JSONRPC::Request](#jsonrpcrequest)
- [JSONRPC::Notification](#jsonrpcnotification)
- JSONRPC::RPCObject
  - .response
  - .request
  - .notification
  - .invalid_request_error
  - .parse_error
  - .jsonrpc_specification_violation_error
  - .method_not_found_error
  - .invalid_params_error
  - .internal_error
  - .detailed_internal_error

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

### JSONRPC::Response

```ruby
JSONRPC::Response
JSONRPC::Response.new(jsonrpc: '2.0', result: { some: 'result' }, id: 'sOmEiD')
JSONRPC::Response#jsonrpc (String)
JSONRPC::Response#result (Hash)
JSONRPC::Response#id (String)
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

### JSONRPC::Notification

```ruby
JSONRPC::Notification
JSONRPC::Notification.new(jsonrpc: '2.0', method: 'some.method', params: { some: 'params' })
JSONRPC::Notification#jsonrpc (String)
JSONRPC::Notification#method (String)
JSONRPC::Notification#params (Hash)
```

### JSONRPC::RPCObject.response

```ruby
JSONRPC::RPCObject.response(
  { some: 'data' },
  request_id: SecureRandom.uuid
) # => JSONRPC::Response
```

### JSONRPC::RPCObject.request


```ruby
JSONRPC::RPCObject.request(
  method: 'some.method',
  params: { some: 'params' },
  request_id: SecureRandom.uuid
) # => JSONRPC::Request
```

### JSONRPC::RPCObject.notification

```ruby
JSONRPC::RPCObject.notification(
  method: 'some.method',
  params: { some: 'params' }
) # => JSONRPC::Notification
```

### JSONRPC::RPCObject.invalid_request_error

```ruby
JSONRPC::RPCObject.invalid_request_error({ some: 'data' })
JSONRPC::RPCObject.invalid_request_error({ some: 'data' }, request_id: SecureRandom.uuid)

JSONRPC::ErrorResponse#error
# signature =>
{ code: -32_600, message: 'Invalid Request', data: { some: 'data' } }
```

### JSONRPC::RPCObject.parse_error

```ruby
JSONRPC::RPCObject.parse_error

JSONRPC::ErrorResponse#error
# signature =>
{ code: -32_700, message: 'Parse Error', data: {} }
```

### JSONRPC::RPCObject.jsonrpc_specification_violation_error

```ruby
JSONRPC::RPCObject.jsonrpc_specification_violation_error
JSONRPC::RPCObject.jsonrpc_specification_violation_error(request_id: SecureRandom.uuid)

JSONRPC::ErrorResponse#error
# signature =>
{ code: -33_003, message: 'JSONRPC Specification Violation', data: {} }
```

### JSONRPC::RPCObject.method_not_found_error

```ruby
JSONRPC::RPCObject.method_not_found_error
JSONRPC::RPCObject.method_not_found_error(request_id: SecureRandom.uuid)

JSONRPC::ErrorResponse#error
# signature =>
{ code: -32_601, message: 'Method Not Found', data: {} }
```

### JSONRPC::RPCObject.invalid_params_error

```ruby
JSONRPC::RPCObject.invalid_params_error
JSONRPC::RPCObject.invalid_params_error(request_id: SecureRandom.uuid)

JSONRPC::ErrorResponse#error
# signature =>
{ code: -32_602, message: 'Invalid Params', data: {} }
```

### JSONRPC::RPCObject.internal_error

```ruby
JSONRPC::RPCObject.internal_error('some', 'error', 'code', error_context: { some: 'context' })
JSONRPC::RPCObject.internal_error('some', 'error', 'code', error_context: { some: 'context' }, request_id: SecureRandom.uuid)

JSONRPC::ErrorResponse#error
# signature =>
{
  code: -32_603,
  message: 'Internal Error',
  data: {
    error_codes: ['some', 'error', 'code'],
    error_cotnext: { some: 'context' }
  }
}
```

### JSONRPC::RPCObject.detailed_internal_error

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
