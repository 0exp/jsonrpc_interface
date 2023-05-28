# frozen_string_literal: true

require_relative 'lib/jsonrpc/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = Gem::Requirement.new('>= 3.2')

  spec.name    = 'jsonrpc_interface'
  spec.version = JSONRPC::VERSION
  spec.authors = ['Rustam Ibragimov']
  spec.email   = ['iamdaiver@gmail.com']

  spec.summary     = 'JSONRPC Interface for Ruby projects.'
  spec.description = 'JSONRPC Interface for Ruby projects realised in object oriented way.'
  spec.homepage    = 'https://github.com/0exp/jsonrpc_interface'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri']   = "#{spec.homepage}/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'smart_schema', '~> 0.11'
  spec.add_dependency 'smart_types', '~> 0.8'

  spec.add_development_dependency 'bundler',          '~> 2.4'
  spec.add_development_dependency 'rake',             '~> 13.0'
  spec.add_development_dependency 'rspec',            '~> 3.12'
  spec.add_development_dependency 'armitage-rubocop', '~> 1.51'
  spec.add_development_dependency 'simplecov',        '~> 0.22'
  spec.add_development_dependency 'pry',              '~> 0.14'
  spec.add_development_dependency 'steep',            '~> 1.4'
  spec.add_development_dependency 'rbs',              '~> 3.1'
end
