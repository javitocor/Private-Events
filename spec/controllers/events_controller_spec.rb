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
      @current_user = @user
      expect(get("/events/new")).to route_to("events#new")
    end
  end
  context 'Create an event' do 
    it 'should create a new event' do 
      @user = User.new(id:'1', name:'peter', email:'peter@gmail.com').save
      @event = Event.new(id:'1', title: "Party", description: "party super cool", location: "gotham", date: "2023-05-19 01:00:00", creator_id:'1')
      expect(@event.save).to eq(true)
    end
  end
  
end

RSpec.describe EventsController, type: :feature do
  context 'Attend an event' do 
    it 'should create and attendance for an event' do 
      @user = User.new(id:'1', name:'peter', email:'peter@gmail.com').save
      @event = Event.new(id:'1', title: "Party", description: "party super cool", location: "gotham", date: "2023-05-19 01:00:00", creator_id:'1').save
      @attend = Attendance.new(attendee_id: '1', attended_event_id: '1')
      expect(@attend.save).to eq(true)
    end
  end
end

RSpec.describe 'create new event and redirect to event show page', type: :feature do
  let(:user) { User.create(name: 'Peter', email: 'peter@example.com') }
  let(:event) { Event.create(title: "Party", description: "party super cool", location: "gotham", date: "2023-05-19 01:00:00", creator_id:'1') }

  scenario 'create event' do
    @current_user = user.id
    visit new_event_path
    fill_in 'event_title', with: event.title
    fill_in 'event_description', with: event.description
    fill_in 'event_location', with: event.location
    fill_in 'event_date', with: event.date
    click_button 'Create Event'
    sleep(3)
    expect(page).to have_content(event.title)    
  end
end

RSpec.describe 'attend an event', type: :feature do
  let(:user) { User.create(name: 'Peter', email: 'peter@example.com') }
  let(:event) { Event.create(title: "Party", description: "party super cool", location: "gotham", date: "2023-05-19 01:00:00", creator_id:'1') }

  scenario 'attend event' do
    visit event_path(event)
    click_button 'Attend'
    sleep(3)
    expect(page).to have_content('Peter')    
  end
end

  