# frozen_string_literal: true

# Created only for studying chapter 5. Remember to rename accordingly and to
# delete one of the two files that we are expecting to be identical by the end
# of this chapter.
module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  class Ledger

    EXPENSES = DB[:expenses]

    def record(expense)
      if expense.key?(:payee)
        id = EXPENSES.insert(expense)
        RecordResult.new(true, id, nil)
      else
        message = 'Invalid expense `payee` is required'
        RecordResult.new(false, nil, message)
      end
    end

    def expenses_on(date)
      p EXPENSES.where(date: date).all
    end
  end
end
