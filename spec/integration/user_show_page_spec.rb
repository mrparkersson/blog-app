require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  describe 'User' do
    before(:each) do
      @user1 = User.create!(email: 'parker@gmail.com', password: 'abcdef',
        name: 'parker', bio: 'parker\'s bio...',
        photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80')

visit '/users/sign_in'
fill_in 'Email', with: 'furkan@gmail.com'
fill_in 'Password', with: '123456'
click_button 'Log in'

@post1 = @user1.posts.create!(title: 'test_1', text: 'Test cases 1', comments_counter: 0, likes_counter: 0,
  user_id: @user1.id)
@post2 = @user1.posts.create!(title: 'test_2', text: 'Test cases 2', comments_counter: 0, likes_counter: 0,
  user_id: @user1.id)
@post3 = @user1.posts.create!(title: 'test_3', text: 'Test cases 3', comments_counter: 0, likes_counter: 0,
  user_id: @user1.id)

  visit user_posts_path(@user1)
    end

    it 'shows photo' do
      image = page.all('img')
      expect(image.size).to eql(0)
    end

    it 'shows the username' do
      expect(page).to have_content('parker')
    end

    it 'shows number of posts for each user' do
      user = User.first
      expect(page).to have_content(user.posts_counter)
    end

    it 'shows the users bio' do
      expect(page).to have_content('I am full-stack dev')
      visit user_session_path
    end

    it 'Should see the user\'s first 3 posts.' do
      expect(page).to have_content 'The big question is: "To be or not to be a Ruby programmer"'
      expect(page).to have_content 'Why people say HTML is not a programming language...'
      expect(page).to have_content 'With the clif hanger seen in the first half of season 4, do you think...'
    end

    it 'Can see a button that lets me view all of a users posts' do
      expect(page).to have_content('See all post')
    end

    it 'When I click to see all posts, it redirects me to the users posts index page.' do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@user1)
    end
  end
end