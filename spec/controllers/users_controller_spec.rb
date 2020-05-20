require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'GET controller views' do 
    it 'GET #index' do 
      get :index
      expect(response).to be_successful
    end
    it 'GET #show' do 
      @user = User.new(id:'1', name:'peter', email:'peter@gmail.com').save
      get :show, params: { id: '1'}
      expect(response).to be_successful
    end
    it 'GET #new' do 
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
  