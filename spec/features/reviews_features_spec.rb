require 'rails_helper'
require_relative '../helpers/session_helpers'
include Session

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}
  before {User.create email: 'test@test.com',
                        password: 'pAssw0rd',
                        password_confirmation: 'pAssw0rd'}

  scenario 'allows users to leave reviews using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'deleting restaurants' do
    sign_in 'test@test.com', 'pAssw0rd'
    click_link 'Delete KFC'
    expect(page).not_to have_content 'KFC'
    expect(page).to have_content 'Restaurant deleted!'
  end

  describe Review do
    it { should belong_to(:restaurant)}
  end



end
