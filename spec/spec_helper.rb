# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'rspec'
require 'simplecov'
require 'simplecov-console'


RSpec.configure do |config|
  config.order = :random
  # conditional loading of the support/bd file only when an example has a :db tag
  config.when_first_matching_example_defined(:db) do
    require_relative 'support/db'
  end
  config.include Rack::Test::Methods
end

RSpec.configure do |rspec|
  rspec.alias_example_group_to :pdescribe, ​pry: true
  rspec.alias_example_to :pit, ​pry: true
  rspec.after(:example, ​pry: true) do |ex|
    require 'pry'
    # binding.pry
  end
end

SCF = SimpleCov::Formatter
formatters = [SCF::Console, SCF::HTMLFormatter]
SimpleCov.formatter = SCF::MultiFormatter.new(formatters)

SimpleCov.start
