# frozen_string_literal: true

require 'rack/test'
require 'json'
require_relative '../../app/api'

module ExpenseTracker
  describe 'ExpenseTracker API' do
    include Rack::Test::Methods

    def app
      ExpenseTracker::API.new
    end

    it 'records submitted expenses' do
      coffee = {
        'payee': :Starbucks,
        'amount': 5.75,
        'date': '2017-06-10'
      }
      # Verifying that the POST request ONLY completes without crashing the app.
      post '/expenses', JSON.generate(coffee)
    end
  end
end
