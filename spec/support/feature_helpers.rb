module Feature_helpers

  def register_user(email)
    visit '/'
    click_link('Sign up')
    fill_in('Email', with: email)
    fill_in('Password', with:'testtest')
    fill_in('Password confirmation', with:'testtest')
    click_button('Sign up')
  end

  def create_restaurant()
    visit '/restaurants'
    click_link('Add a restaurant')
    fill_in('Name', with: 'KFC')
    click_button('Create Restaurant')
  end

end
