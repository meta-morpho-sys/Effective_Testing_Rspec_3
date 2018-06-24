# frozen_string_literal: true

require 'sinatra/base'
require 'json'
require_relative 'ledger_b'

module ExpenseTracker
  # Routing code for expenses creation and look-up.
  class API < Sinatra::Base

    def initialize(ledger: Ledger.new)
      @ledger = ledger
      super()
    end

    post '/expenses' do
      expense = JSON.parse(request.body.read)
      result = @ledger.record(expense)
      if result.success?
        JSON.generate('expense_id' => result.expense_id)
      else
        status 422
        JSON.generate('error' => result.error_message)
      end
    end

    get '/expenses/:date' do
      date = params[:date]
      result = @ledger.expenses_on(date)
      if result.empty?
        JSON.generate('No expenses for this date')
      else
        JSON.generate(result)
      end

    end
  end
end
