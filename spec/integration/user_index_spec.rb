require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  describe 'User' do
    before(:each) do
      @user1 = User.create! name: 'parker', password: '123456', email: 'parker@gmail.com', confirmed_at: Time.now
      @user2 = User.create! name: 'furkan', password: '123456', email: 'furkan@gmail.com', confirmed_at: Time.now
      visit user_posts_path(@user1)
      fill_in 'Email', with: 'parker@gmail.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      visit user_posts_path(@user1)
    end

    it 'shows the username of other users' do
      expect(page).to have_content('parker')
      expect(page).to have_content('parker')
    end

    it 'shows photo' do
      image = page.all('img')
      expect(image.size).to eql(0)
    end

    it 'shows number of posts for each user' do
      expect(page).to have_content('Number of posts: 0')
    end

    it 'show users page when clicked' do
      expect(page).to have_content('Number of posts: 0')
      click_on 'parker'
      expect(page).to have_current_path user_path(@user1)
      expect(page).to have_no_content('parker')
    end
  end
end
