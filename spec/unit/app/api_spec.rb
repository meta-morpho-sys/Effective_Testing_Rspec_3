# frozen_string_literal: true

require_relative '../../../app/api'

module ExpenseTracker
  describe API do
    def app
      API.new(ledger: ledger)
    end

    let(:ledger) { instance_double('ExpenseTracker::Ledger') }

    describe "POST '/expenses'" do
      let(:parsed) { JSON.parse(last_response.body) }

      context 'when the expense is successfully recorded' do
        let(:expense) { { 'some' => 'data' } }
        before do
          allow(ledger).to receive(:record)
            .with(expense)
            .and_return(RecordResult.new(true, 417, nil))
        end
        it 'returns the expense id' do
          post '/expenses', JSON.generate(expense)
          expect(parsed).to include('expense_id' => 417)
        end

        it 'responds with a 200 (OK)' do
          post '/expenses', JSON.generate(expense)
          expect(last_response.status).to eq 200
        end
      end

      context 'when the expense fails validation' do
        let(:expense) { { 'some' => 'data' } }
        before do
          allow(ledger).to receive(:record)
            .with(expense)
            .and_return(RecordResult.new(false, 417, 'Expense incomplete'))
        end

        it 'returns an error message' do
          post '/expenses', JSON.generate(expense)
          expect(parsed).to include('error' => 'Expense incomplete')
        end

        it 'responds with a 422 (Unprocessable entity)' do
          post '/expenses', JSON.generate(expense)
          expect(last_response.status).to eq 422
        end
      end
    end

    describe "GET '/expenses/:date'" do
      context 'when expenses exist for the given date' do
        before do
          allow(ledger).to receive(:expenses_on)
            .with('2017-06-12')
            .and_return(%w[coffee zoo])
        end

        it 'returns the expense records as JSON' do
          get '/expenses/2017-06-12'
          parsed = JSON.parse(last_response.body)
          expect(parsed).to eq(%w[coffee zoo])
        end

        it 'responds with a 200 (OK)' do
          get '/expenses/2017-06-12'
          expect(last_response.status).to eq 200
        end
      end

      context 'when there are no expenses for the given date' do
        it 'returns an empty JSON array'
        it 'responds with a 200 (OK)'
      end
    end
  end
end
