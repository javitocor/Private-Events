require 'rails_helper'
require 'capybara/rspec'

RSpec.describe UsersController, type: :controller do
  context 'GET users controller views' do 
    it 'GET #index' do 
      get :index
      expect(response).to be_successful
    end
    it 'GET #show' do 
      @user = User.new(id:'1', name:'peter', email:'peter@gmail.com').save
      get :show, params: { id: '1'}
      expect(response).to be_successful
    end
    it 'GET #new/sign up page' do 
      get :new
      expect(response).to be_successful
    end
  end
  
  context 'Create user' do 
    it 'should create a user' do 
      @user = User.new(id:'1', name:'peter', email:'peter@gmail.com')
      expect(@user.save).to eq(true)
    end
  end 
end


RSpec.describe 'Sign up fields', type: :feature do
  describe 'fields in sign up page' do
    it 'name field in signup page' do
      visit new_user_path
      expect(page).to have_content 'Name'
    end
    it 'email field in signup page' do
      visit new_user_path
      expect(page).to have_content 'Email'
    end
  end
end

RSpec.describe 'create user and redirect to user show page', type: :feature do
  let(:user) { User.create(name: 'Peter', email: 'peter@example.com') }

  scenario 'create user' do
    visit new_user_path
    fill_in 'user_name', with: user.name
    fill_in 'user_email', with: user.email
    click_button 'Create User'
    sleep(3)
    expect(page).to have_content('Upcoming Hosted Events')    
  end
end