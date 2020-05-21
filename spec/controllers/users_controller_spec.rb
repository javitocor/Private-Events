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

  describe 'Create and redirect' do
    subject { post :create, :params => { :user => {:name =>"Abcde", :email=>"abcde@gmail.com"}}}
    it "redirects to user show page" do
      expect(subject).to redirect_to  :action => :show,
                                      :id => assigns(:user).id
    end
    it "redirects to user show page" do
      expect(subject).to redirect_to(user_url(assigns(:user)))
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