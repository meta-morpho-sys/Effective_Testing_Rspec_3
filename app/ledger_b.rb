# frozen_string_literal: true

# Created only for studying chapter 5. Remember to rename accordingly and to
# delete one of the two files that we are expecting to be identical by the end
# of this chapter.
module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  class Ledger

    def record(expense); end

    def expenses_on(date); end
  end
end
