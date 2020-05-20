require 'rails_helper'
require 'capybara/rspec'

RSpec.describe SessionsController, type: :controller do
  let(:user) { User.create(name: 'Peter', email: 'peter@example.com') }

  scenario 'login page' do
    visit root_path
    fill_in 'session_username', with: user.name
    click_button 'Log in'
    sleep(3)
    expect(page).to have_content('Created Events')
    click_on 'Logout'
    sleep(3)
    expect(page). to have_content('Log In')
  end
end

