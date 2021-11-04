module LoginModule
  def login(user)
    visit login_path
    fill_in 'Name', with: 'user'
    fill_in 'Email', with: user.email
    fill_in 'Phonenumber', with: user.phonenumber
    fill_in 'Password', with: 'pass1111'
    click_button 'Login'
  end
end
