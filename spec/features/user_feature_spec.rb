require 'rails_helper'

feature "Signing in and signing out: " do
  context "User not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "Should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "User signed in the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'pAssw0rd')
      fill_in('Password confirmation', with: 'pAssw0rd')
      click_button('Sign up')
    end

    it "Should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "Should not see 'sign in' or 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end
   end
 end

