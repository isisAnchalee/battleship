require 'rails_helper'

RSpec.feature 'Sessions Controller', :type => :feature do
  describe 'the signin process' do
    let(:user){ FactoryGirl.create(:user) }
   
    scenario 'User signs in with email' do
      visit 'users/login'
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      byebug
      click_button 'Log in'
      # expect(user.persisted?).to be true
      expect(page).to have_content 'CREATE NEW GAME'
    end

    scenario 'User signs in with invalid email' do
      visit 'users/login'
      fill_in 'email', with: 'me@me.com'
      fill_in 'password', with: 'password'
      click_button 'Log in'
      expect(page).to have_content 'Sign up'
    end

    scenario 'User signs out' do
      visit 'users/login'
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Log in'
      save_and_open_page
      click_link 'Sign Out'
      expect(page).to have_content 'Sign In'
    end
  end
end
