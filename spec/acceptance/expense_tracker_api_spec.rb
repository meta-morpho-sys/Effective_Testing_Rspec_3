# frozen_string_literal: true

# require 'rack/test'
require 'json'
require_relative '../../app/api'

module ExpenseTracker

  describe 'ExpenseTracker API' do
    # include Rack::Test::Methods

    def app
      ExpenseTracker::API.new
    end

    def record_to_hash
      JSON.parse(last_response.body)
    end

    def post_expense(expense)
      post '/expenses', JSON.generate(expense)
      expect(last_response.status).to eq 200

      parsed = record_to_hash
      expect(parsed).to include('expense_id' => a_kind_of(Integer))
      expense.merge('id' => parsed['expense_id'])
    end

    it 'records submitted expenses' do
      # pending 'needs to persist expenses'
      coffee = post_expense(
        'payee': :Starbucks,
        'amount': 5.75,
        'date': '2017-06-10'
      )
      zoo = post_expense(
        'payee': :Zoo,
        'amount': 15.25,
        'date': '2017-06-10'
      )
      groceries = post_expense(
        'payee': :'Whole Foods',
        'amount': 95.20,
        'date': '2017-06-11'
      )

      get '/expenses/2017-06-10'
      expect(last_response.status).to eq 200
      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly coffee, zoo
      expect(expenses).to_not include groceries
    end
  end
end
