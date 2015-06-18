require 'rails_helper'
require_relative '../helpers/session_helpers'
include Session

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      sign_up
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'does not let user create a restaurant if they are not logged in' do
      visit '/restaurants'
      expect(page).not_to have_link 'Add a restaurant'
    end
  end

  context 'an invalid restaurant' do
    it 'does not let you submit if the name is too short' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'ff'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end

    it 'is not valid unless it has a unique name' do
      Restaurant.create(name: "Moe's Tavern")
      restaurant = Restaurant.new(name: "Moe's Tavern")
      expect(restaurant).to have(1).error_on(:name)
    end

  end

  context 'viewing restaurants' do

    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'lets a user visit a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before {Restaurant.create name: 'KFC'}
    before {User.create email: 'test@test.com',
                        password: 'pAssw0rd',
                        password_confirmation: 'pAssw0rd'}

    scenario 'lets the user edit a restaurant' do
      sign_in 'test@test.com', 'pAssw0rd'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do

    before {Restaurant.create name: 'KFC'}
     before {User.create email: 'test@test.com',
                        password: 'pAssw0rd',
                        password_confirmation: 'pAssw0rd'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_in 'test@test.com', 'pAssw0rd'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted!'
    end
  end

end
