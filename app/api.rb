# frozen_string_literal: true

require 'sinatra/base'
require 'json'

module ExpenseTracker
  # Routing code for expenses creation and look-up.
  class API < Sinatra::Base

    get '/expenses/:date' do
      JSON.generate([])
    end
    post '/expenses' do
      JSON.generate('expense_id': 42)
    end
  end
end
