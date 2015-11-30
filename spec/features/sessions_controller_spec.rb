require 'rails_helper'

RSpec.feature 'Sessions Controller', :type => :feature do
  describe 'the signup process' do 

    scenario 'user signs up without email' do
      visit 'users/sign_up'
      fill_in 'email-field', with: ''
      fill_in 'pw-field', with: 'testing'
      click_button 'Sign up'
      expect(page).to have_content 'Email can\'t be blank'
    end

    scenario 'user signs in with invalid email' do
      visit 'users/login'
      fill_in 'email', with: 'butts'
      fill_in 'password', with: 'password'
      click_button 'Log in'
      expect(page).to have_content 'Sign up'
    end

    scenario 'with valid credentials' do
      visit 'users/sign_up'
      fill_in 'email-field', with: 'testing@test.test'
      fill_in 'pw-field', with: 'test'
      click_button 'Sign up'
      expect(page).to have_content 'You have signed up successfully'
    end

    scenario 'new user signs out' do
      visit 'users/sign_up'
      fill_in 'email-field', with: 'testing@test.test'
      fill_in 'pw-field', with: 'test'
      click_button 'Sign up'
      expect(page).to have_content 'You have signed up successfully'
      click_link 'Sign Out'
      expect(page).to have_content 'Sign In'
    end
  end


  describe 'the signin process' do
    let(:user){ FactoryGirl.create(:user) }
   
    scenario 'user signs in with email' do
      visit 'users/login'
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Log in'
      expect(user.persisted?).to be true
    end

    scenario 'user signs in with invalid email' do
      visit 'users/login'
      fill_in 'email', with: 'me@me.com'
      fill_in 'password', with: 'password'
      click_button 'Log in'
      expect(page).to have_content 'Sign up'
    end
  end
end
