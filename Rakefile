# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop'
require 'rubocop/rake_task'
require 'rubocop-performance'
require 'rubocop-rspec'
require 'rubocop-rake'
require 'steep'
require 'steep/cli'

RuboCop::RakeTask.new(:rubocop) do |t|
  config_path = File.expand_path(File.join('.rubocop.yml'), __dir__)
  t.options = ['--config', config_path]
  t.requires << 'rubocop-rspec'
  t.requires << 'rubocop-performance'
  t.requires << 'rubocop-rake'
end

RSpec::Core::RakeTask.new(:rspec)

task :steep do
  Steep::CLI.new(argv: ['check'], stdout: STDOUT, stderr: STDERR, stdin: STDIN).run
end

task default: %w[steep rubocop rspec]
