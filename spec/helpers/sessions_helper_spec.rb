require 'rails_helper'
require 'capybara/rspec'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  context 'sessions helpers test' do 
    before :each do 
      @user = User.new(id:'1', name:'peter', email:'peter@gmail.com').save
    end
    it 'login a user' do 
      assign(:user_id, '1')      
      expect(login(@user)).to eq(1)
    end
    it 'logout a user' do
      logout
      expect(session[:user_id]).to eq(nil)
    end
    it 'assign current user' do 
      login(@user)
      current_user
      expect(@current_user).to eq(User.find(1))
    end
    it 'test if user is logged in' do 
      login(@user)      
      expect(logged_in?).to eq(true)
    end
  end
end


