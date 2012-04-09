require 'minitest_helper'

describe 'Sessions integration' do

  it 'signs me in' do
    User.create(email: 'test@test.com', password: 'foo', password_confirmation: 'foo')
    visit new_session_path
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: 'foo'
    click_button 'Log In'
    page.has_selector?('.alert-info')
  end

  it 'denys bad authentication' do
    visit new_session_path
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: 'foo'
    click_button 'Log In'
    page.has_selector?('.alert-error')
  end

end
