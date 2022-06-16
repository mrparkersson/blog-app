require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  before :each do
    @user = User.create(email: 'test@gmail.com', password: '123asdd', name: 'Test', bio: 'Test bio.')
    visit '/users/sign_in'
  end

  it 'should havethe username and password inputs and the "Submit" button' do
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_button('Log in')
  end

  it 'should display an error when clicked the submit button without filling in the username and the password' do
    click_button 'Log in'
    expect(page).to have_content('Log in')
  end

  it 'should display an error when clicked the submit button after filling with incorrect data' do
    fill_in 'Email', with: 'test@gmail.com'
    fill_in 'Password', with: '12345'
    click_button 'Log in'
    expect(page).to have_content('Log in')
    fill_in 'Email', with: 'tests@gmail.com'
    fill_in 'Password', with: '123asdd'
    click_button 'Log in'
    expect(page).to have_content('Log in')
  end

  it 'should route to the root path and display flash message for valid credentials' do
    fill_in 'Email', with: 'test@gmail.com'
    fill_in 'Password', with: '123asdd'
    click_button 'Log in'
    expect(current_path).to eq(authenticated_root_path)
    expect(page).to have_content('Signed in successfully.')
  end
end