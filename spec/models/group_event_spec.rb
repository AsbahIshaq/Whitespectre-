require 'rails_helper'

RSpec.describe GroupEvent, type: :model do

  describe 'calculate dates between events' do
    let(:user) { User.create() }
    let(:event1) { GroupEvent.create(created_by_id: user.id) }
    let(:event2) { GroupEvent.create(created_by_id: user.id) }
    context 'when overlapping' do
      it 'returns overlap string when exactly the same' do
        event1.start_date = DateTime.now - 10
        event1.end_date = DateTime.now - 5

        event2.start_date = DateTime.now - 10
        event2.end_date = DateTime.now - 5

        result = GroupEvent.calculate_dates_between_events(event1, event2)
        expect(result).to eq 'Events are overlapping'
      end

      it 'returns overlap string when start_date is between start and end date of the other' do
        event1.start_date = DateTime.now - 10
        event1.end_date = DateTime.now - 5

        event2.start_date = DateTime.now - 11
        event2.end_date = DateTime.now - 5

        result = GroupEvent.calculate_dates_between_events(event1, event2)
        expect(result).to eq 'Events are overlapping'
      end
    end

    context 'when not overlapping' do
      it 'returns dates' do
        event1.start_date = DateTime.now - 10
        event1.end_date = DateTime.now - 8

        event2.start_date = DateTime.now - 7
        event2.end_date = DateTime.now - 5

        result = GroupEvent.calculate_dates_between_events(event1, event2)
        expect(result).to eq [event1.end_date .. event2.start_date]
      end
    end
  end
end