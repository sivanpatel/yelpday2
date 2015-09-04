require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
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
      register_user('test@test.com')
      create_restaurant
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'user must be logged in to create a restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        register_user('test@test.com')
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end

  end

  context 'viewing restaurants' do
    scenario 'lets a user view a restaurant' do
      register_user('test@test.com')
      create_restaurant
      visit '/restaurants'
      restaurant = Restaurant.find_by(name:'KFC')
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{restaurant.id}"
    end
  end

  context 'editing restaurants' do

    scenario 'let a user edit a restaurant' do
      register_user('test@test.com')
      create_restaurant
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: "Kentucky Fried Chicken"
      click_button 'Update Restaurant'
      expect(page).to have_content "Kentucky Fried Chicken"
      expect(current_path).to eq '/restaurants'
    end

    scenario 'does not allow a user to edit a restaurant they did not create' do
      register_user('test@test.com')
      create_restaurant
      click_link 'Sign out'
      register_user('test2@test.com')
      visit '/restaurants'
      expect(page).not_to have_content('Edit KFC')
    end

    scenario 'does not allow a user to edit a restaurant they did not create' do
      register_user('test@test.com')
      create_restaurant
      click_link 'Sign out'
      register_user('test2@test.com')
      visit '/restaurants'
      click
      expect(page).not_to have_content('Edit KFC')
    end

  end

  context 'deleting restaurants' do

    before {Restaurant.create name: 'Nandos'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      register_user('test@test.com')
      create_restaurant
      visit '/restaurants'
      expect(page).to have_content('Delete KFC')
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'does not allow a user to delete a restaurant they did not create' do
      register_user('test@test.com')
      create_restaurant
      click_link 'Sign out'
      register_user('test2@test.com')
      visit '/restaurants'
      expect(page).not_to have_content('Delete KFC')
    end
  end

end
