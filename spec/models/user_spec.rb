require 'rails_helper'

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
    let (:user) { User.new(name: 'abc', email:'john@abc.com').save } 
    let (:event) {Event.new(title: "Party", description: "party super cool", location: "gotham", date: "2020-05-19 01:00:00").save}
    let (:attendance) {Attendance.new(attendee_id: user.id, attended_events_id: event.id)}

    it 'validate past events' do       
      expect(user.past_events).to eq(true)
    end
    it 'validate upcoming events' do 
      user.attended_events.create(title:'abdc', description:'asdasdas', location:'here', date: DateTime.parse('2023-02-03T04:05:06+07:00')
    )
    expect(user.upcoming_events).to eq(true)
    end
  end
end
