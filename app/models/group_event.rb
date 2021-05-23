class GroupEvent < ApplicationRecord
  belongs_to :user, foreign_key: :created_by_id
  validates :name, :description, :location, :start_date, :end_date, :created_by_id, presence: true, if: :is_published? 

  def delete_event
    is_deleted = true
    save
  end

  def self.calculate_dates_between_events(event1, event2)
    if event2.start_date > event1.end_date
      [event1.end_date .. event2.start_date]
    elsif event1.start_date > event2.end_date
      [event2.end_date .. event1.start_date]
    else
      'Events are overlapping'
    end
  end
end
