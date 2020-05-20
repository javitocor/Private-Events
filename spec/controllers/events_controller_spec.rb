require 'rails_helper'
require 'capybara/rspec'

RSpec.describe EventsController, type: :controller do
  context 'GET events controller views' do 
    before(:each) do 
      @user = User.new(id:'1', name:'peter', email:'peter@gmail.com').save
      @event = Event.new(id:'1', title: "Party", description: "party super cool", location: "gotham", date: "2023-05-19 01:00:00", creator_id:'1').save      
    end 
    it 'GET #index' do 
      get :index
      expect(response).to be_successful
    end
    it 'GET #show' do
      get :show, params: { id: '1'}
      expect(response).to be_successful
    end
    it 'GET #new' do 
      get :new
      expect(response).to be_successful
    end
  end
  context 'Create an event' do 
    it 'should create a new event' do 
      @user = User.new(id:'1', name:'peter', email:'peter@gmail.com').save
      @event = Event.new(id:'1', title: "Party", description: "party super cool", location: "gotham", date: "2023-05-19 01:00:00", creator_id:'1')
      expect(@event.save).to eq(true)
    end
  end
  context 'Attend an event' do 
    it 'should create and attendance for an event' do 
      @user = User.new(id:'1', name:'peter', email:'peter@gmail.com').save
      @event = Event.new(id:'1', title: "Party", description: "party super cool", location: "gotham", date: "2023-05-19 01:00:00", creator_id:'1')
      @attend = Attendance.new(attendee_id: @user.id, attended_event_id: @event.id)
      expect(@attend.save).to eq(true)
    end
  end
end
  