module Session

  def sign_up
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'pAssw0rd')
    fill_in('Password confirmation', with: 'pAssw0rd')
    click_button('Sign up')
  end

  def sign_in(email, password)
    visit('/')
    click_link('Sign in')
    fill_in('Email', with: email)
    fill_in('Password', with: password)
    click_button('Log in')
  end
end