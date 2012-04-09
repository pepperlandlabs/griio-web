require 'minitest_helper'

describe 'User integration' do

  it 'is created by submitting a form' do
    visit new_user_path
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'blablabla'
    fill_in 'user_password_confirmation', with: 'blablabla'
    click_button 'Sign Up'
    current_path.must_equal root_path
    User.find_by_email('test@test.com').must_be_instance_of User
  end

  it 'must deny a duplicate email address' do
    User.create(email: 'test@test.com', password: 'bla', password_confirmation: 'bla')
    visit new_user_path
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'foo'
    fill_in 'user_password_confirmation', with: 'foo'
    click_button 'Sign Up'
    page.has_selector?('alert-error')
    page.has_content?('has already been taken')
  end

  it 'must deny an uncomfirmed password' do
    visit new_user_path
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'foo'
    fill_in 'user_password_confirmation', with: 'bar'
    click_button 'Sign Up'
    page.has_selector?('alert-error')
    page.has_content?("doesn't match confirmation")
  end

  it 'must deny no password' do
    visit new_user_path
    fill_in 'user_email', with: 'test@test.com'
    click_button 'Sign Up'
    page.has_selector?('alert-error')
  end

  it 'must deny no email' do
    visit new_user_path
    click_button 'Sign Up'
    page.has_selector?('alert-error')
  end

end

