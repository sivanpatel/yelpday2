require 'rails_helper'
require_relative '../helpers/omniauth_helper'

feature 'User can sign in and out' do
  context 'user not signed in and on the homepage' do
    it 'should see a sign in link, and a sign up link' do
      visit '/'
      expect(page).to have_link("Sign in")
      expect(page).to have_link("Sign up")
    end

    it 'should not see a sign out link' do
      visit '/'
      expect(page).not_to have_link("Sign out")
    end
  end

  context 'user signed in on the homepage' do
    before do
      visit '/'
      click_link "Sign up"
      fill_in('Email', with:'test@test.com')
      fill_in('Password', with:'testtest')
      fill_in('Password confirmation', with:'testtest')
      click_button('Sign up')
    end

    it 'should see sign out link' do
      visit '/'
      expect(page).to have_link("Sign out")
    end

    it 'should not see a sign in, or sign up link' do
      visit '/'
      expect(page).not_to have_link("Sign in")
      expect(page).not_to have_link("Sign up")
    end
  end

  context 'using facebook' do
    it 'should see sign in with facebook link' do
      visit '/'
      expect(page).to have_link("Sign in with Facebook")
    end

  end

  feature 'Sign in via Facebook' do

   scenario 'click login via facebook' do
      visit '/'
      set_omniauth()
      click_link 'Sign in with Facebook'
      expect(page).to have_content('Successfully authenticated from Facebook account.')
    end
  end
end
