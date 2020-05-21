require 'rails_helper'
require 'capybara/rspec'
# rubocop:disable  Layout/LineLength
RSpec.describe Event, type: :model do
  context 'validation tests' do
    it 'validate title is not empty' do
      @event = Event.new(description: 'asdasdas', location: 'here', date: DateTime.parse('2001-02-03T04:05:06+07:00')).save
      expect(@event).to eq(false)
    end
    it 'validate description is not empty' do
      @event = Event.new(title: 'adb', location: 'here', date: DateTime.parse('2001-02-03T04:05:06+07:00')).save
      expect(@event).to eq(false)
    end
    it 'validate location is not empty' do
      @event = Event.new(title: 'adb', description: 'asdasdas', date: DateTime.parse('2001-02-03T04:05:06+07:00')).save
      expect(@event).to eq(false)
    end
    it 'validate description is not empty' do
      @event = Event.new(title: 'adb', location: 'here', description: 'asdasdas').save
      expect(@event).to eq(false)
    end
  end

  context 'scopes tests' do
    let(:params) { { title: 'Party', description: 'party super cool', location: 'gotham', date: '2020-05-19 01:00:00', creator_id: '1' } }
    before(:each) do
      @user = User.new(id: '1', name: 'peter', email: 'peter@gmail.com').save
      Event.new(params).save
      Event.new(params).save
      Event.new(params).save
      Event.new(params.merge(date: '2023-05-19 01:00:00')).save
    end

    it 'should return past events' do
      expect(Event.past.size).to eq(3)
    end
    it 'should return upcoming events' do
      expect(Event.upcoming.size).to eq(1)
    end
  end
  context 'Events associations tests' do
    it { should have_many(:attendees).through(:attendances).source(:attendee) }
    it { should have_many(:attendances).with_foreign_key('attended_event_id') }
    it { should belong_to(:creator).class_name('User') }
  end
end
# rubocop:enable  Layout/LineLength
