require 'rails_helper'
require_relative '../helpers/session_helpers'
include Session

feature 'Reviewing: ' do

  before {User.create email: 'test@test.com',
                        password: 'pAssw0rd',
                        password_confirmation: 'pAssw0rd'}
  before {Restaurant.create name: 'KFC', user: User.last}

  scenario 'Allows users to leave reviews using a form' do
    sign_in 'test@test.com'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'Deleting restaurants also deletes reviewes' do
    sign_in 'test@test.com'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so-so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Delete KFC'
    expect(page).not_to have_content 'so-so'
  end

  describe Review do
    it { is_expected.to belong_to(:restaurant)}
  end

end
