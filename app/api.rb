# frozen_string_literal: true

require 'sinatra/base'
require 'json'

module ExpenseTracker
  # Routing code for expenses creation and look-up.
  class API < Sinatra::Base
    post '/expenses' do
      JSON.generate('expense_id': 42)
    end
  end
end
