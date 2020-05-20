class Event < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :date, presence: true

  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :attendances, source: :attendee

  scope :past, -> { where('date < ?', Date.today) }
  scope :upcoming, -> { where('date > ?', Date.today) }
end
