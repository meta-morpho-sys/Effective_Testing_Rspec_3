# frozen_string_literal: true

require 'sinatra/base'
require 'json'
require_relative '../config/sequel_db_setup'
require_relative 'ledger'

module ExpenseTracker
  # Routing code for expenses creation and look-up.
  class API < Sinatra::Base

    def initialize(ledger: Ledger.new)
      @ledger = ledger
      super()
    end

    post '/expenses' do
      expense = JSON.parse(request.body.read, symbolize_names: true)
      result = @ledger.record(expense)
      if result.success?
        JSON.generate('expense_id' => result.expense_id)
      else
        status 422
        JSON.generate('error' => result.error_message)
      end
    end

    get '/expenses/:date' do
      result = @ledger.expenses_on(params[:date])
      result.empty? ? JSON.generate('No expenses for this date') : JSON.generate(result)
    end
  end
end
