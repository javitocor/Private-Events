require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'login followed by logout', type: :feature do
  let(:user) { User.create(name: 'Peter', email: 'peter@example.com') }

  scenario 'login page' do
    visit root_path
    fill_in 'session_name', with: user.name
    click_button 'Log In'
    sleep(3)
    expect(page).to have_content('Created Events')
    click_on 'Logout'
    sleep(3)
    expect(page).to have_content('Log In')
  end
end


RSpec.describe 'Log in fields', type: :system do
  describe 'fields in login page' do
    it 'name field in login page' do
      visit login_path
      expect(page).to have_content 'name'
    end
    
  end
end

