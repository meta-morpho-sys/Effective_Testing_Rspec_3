# frozen_string_literal: true

require 'sequel'

db_name = 'expense_tracker'
db_name += '_test' if ENV['RACK_ENV'] == 'test'
DB_NAME = db_name

DB = Sequel.sqlite("./db/#{DB_NAME}.db")
