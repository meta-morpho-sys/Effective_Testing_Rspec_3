# frozen_string_literal: true

require 'rack/test'
require 'json'

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

      post '/expenses', JSON.generate(coffee)
    end
  end
end
