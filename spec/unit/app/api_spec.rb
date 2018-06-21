# frozen_string_literal: true

require_relative '../../../app/api'

module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)


  describe API do

    def app
      API.new(ledger: ledger)
    end

    let(:ledger) { instance_double('ExpenseTracker::Ledger') }

    describe "POST '/expenses'" do
      context 'when the expense is successfully recorded' do
        let(:expense) { { 'some' => 'data' } }
        before do
          allow(ledger).to receive(:record)
            .with(expense)
            .and_return(RecordResult.new(true, 417, nil))
        end
        it 'returns the expense id' do
          post '/expenses', JSON.generate(expense)
          parsed = JSON.parse(last_response.body)
          p last_response.status
          expect(parsed).to include('expense_id' => 417)
        end

        it 'responds with a 200(OK)' do
          post '/expenses', JSON.generate(expense)
          expect(last_response.status).to eq 200
        end
      end

      context 'when the expense fails validation' do
        it 'returns an error message'
        it 'responds with a 422 (Unprocessable entity'
      end
    end
  end
end