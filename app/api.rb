# frozen_string_literal: true

require 'sinatra/base'
require 'json'

module ExpenseTracker
  # Routing code for expenses creation and look-up.
  class API < Sinatra::Base

    def initialize(ledger: Ledger.new)
      @ledger = ledger
      super()
    end

    get '/expenses/:date' do
      JSON.generate([])
    end

    post '/expenses' do
      expense = JSON.parse(request.body.read)
      result = @ledger.record(expense)
      JSON.generate('expense_id' => result.expense_id)
    end
  end
end
