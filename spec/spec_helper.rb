# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'simplecov'
require 'simplecov-console'


RSpec.configure do |config|
  config.order = :random
  # conditional loading of the support/bd file only when an example has a :db tag
  config.when_first_matching_example_defined(:db) do
    require_relative 'support/db'
  end
end

SCF = SimpleCov::Formatter
formatters = [SCF::Console, SCF::HTMLFormatter]
SimpleCov.formatter = SCF::MultiFormatter.new(formatters)

SimpleCov.start
