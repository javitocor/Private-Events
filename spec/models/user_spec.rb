require 'rails_helper'
require 'capybara/rspec'
# rubocop:disable  Layout/LineLength
RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'validate name is not empty' do
      @user = User.new(email: 'abc@abc.com').save
      expect(@user).to eq(false)
    end
    it 'validate email is not empty' do
      @user = User.new(name: 'abcd').save
      expect(@user).to eq(false)
    end
    it 'validate email format is correct' do
      @user = User.new(name: 'abcde', email: 'john.com').save
      expect(@user).to eq(false)
    end
    it 'should not validate if the name is shorter than 4 characters' do
      @user = User.new(name: 'abc', email: 'john@gmail.com').save
      expect(@user).to eq(false)
    end
  end

  context 'Validate model helper methods' do
    let(:user) { User.create(name: 'Peter', email: 'peter@example.com') }
    let(:event) { Event.create(title: 'Party', description: 'party super cool', location: 'gotham', date: '2023-05-19 01:00:00', creator_id: '1') }
    let(:event2) { Event.create(title: 'Party', description: 'party super cool', location: 'gotham', date: '2018-05-19 01:00:00', creator_id: '1') }
    before(:each) do
      Attendance.new(attendee_id: user.id, attended_event_id: event.id).save
      Attendance.new(attendee_id: user.id, attended_event_id: event2.id).save
    end
    it 'should return past events' do
      expect(user.past_events.size).to eq(1)
    end
    it 'should return upcoming events' do
      expect(user.upcoming_events.size).to eq(1)
    end
  end
  context 'User associations tests' do
    it { should have_many(:created_events).with_foreign_key('creator_id') }
    it { should have_many(:attendances).with_foreign_key('attendee_id') }
    it { should have_many(:attended_events).through(:attendances).source(:attended_event) }
  end
end
# rubocop:enable  Layout/LineLength
