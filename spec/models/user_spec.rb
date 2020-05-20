require 'rails_helper'
require 'capybara/rspec'

RSpec.describe User, type: :model do
  context 'validation tests' do 
    it 'validate name is not empty' do 
      @user = User.new(email: 'abc@abc.com').save
      expect(@user).to eq(false)
    end
    it 'validate email is not empty' do 
      @user = User.new(name: 'abc').save
      expect(@user).to eq(false)
    end
    it 'validate email format is correct' do 
      @user = User.new(name: 'abc', email:'john.com').save
      expect(@user).to eq(false)
    end
  end

  context 'Validate model helper methods' do
    before(:each) do 
      @user = User.new(id:'1', name:'peter', email:'peter@gmail.com').save
      @event = Event.new(id:'1', title: "Party", description: "party super cool", location: "gotham", date: "2023-05-19 01:00:00", creator_id:'1').save
      Attendance.create(attendee_id: @user.id, attended_event_id: @event.id)
    end 
    it 'should return past events' do       
      expect(@user.past_events.size).to eq(0)
    end
    it 'should return upcoming events' do 
      expect(@user.upcoming_events.size).to eq(1)
    end
  end
end
