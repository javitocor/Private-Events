class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { minimum: 4 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :created_events, foreign_key: :creator_id, class_name: 'Event'
  has_many :attendances, foreign_key: :attendee_id
  has_many :attended_events, through: :attendances

  def past_events
    attended_events.where('date < ?', Date.today)
  end

  def upcoming_events
    attended_events.where('date > ?', Date.today)
  end
end
