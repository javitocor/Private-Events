class User < ApplicationRecord
  has_many :created_events, foreign_key: :creator_id, class_name: 'Event'
  has_many :attendances, foreign_key: :attendee_id
  has_many :attended_events, through: :attendances, source: :attended_event

  def past_events
    attended_events.where('date < ?', Date.today) 
  end

  def upcoming_events
    attended_events.where('date > ?', Date.today)
  end
end
