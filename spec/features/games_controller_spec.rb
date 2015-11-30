RSpec.feature 'Games Controller', :type => :feature do
  describe 'the creation process' do
    let(:user){ FactoryGirl.create(:user) }
    
    scenario 'Without user logged in' do
      visit '/'
      expect(page).to have_content 'Sign up'
    end

    scenario 'creating new game' do 
      visit 'users/sign_up'
      fill_in 'email-field', with: 'testing@test.test'
      fill_in 'pw-field', with: 'test'
      click_button 'Sign up'
      fill_in 'new-game-field', with: 'test room'
      click_button 'Create New Game'
      expect(page).to have_content 'test room'
    end

    scenario 'visiting games index' do 
      visit 'users/sign_up'
      fill_in 'email-field', with: 'testing@test.test'
      fill_in 'pw-field', with: 'test'
      click_button 'Sign up'
      click_link 'Join Existing'
      expect(page).to have_content 'Games'
    end
  end
end
