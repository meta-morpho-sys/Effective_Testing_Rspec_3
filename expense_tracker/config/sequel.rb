# frozen_string_literal: true

require 'sequel'

db_name = 'new_bookmark_manager'
db_name += '_test' if ENV['RACK_ENV'] == 'test'
DB_NAME = db_name

DB = Sequel.postgres(DB_NAME)
