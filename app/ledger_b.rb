# frozen_string_literal: true

module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  class Ledger
    EXPENSES = DB[:expenses]

    def record(expense)
      unless expense.key?(:payee)
        message = 'Invalid expense: `payee` is required'
        return RecordResult.new(false, nil, message)
      end
      id = EXPENSES.insert(expense)
      RecordResult.new(true, id, nil)
    end

    def expenses_on(date)
      EXPENSES.where(date: date).all
    end
  end
end
