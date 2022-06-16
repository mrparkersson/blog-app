require 'rails_helper'

RSpec.describe 'Posts show page', type: :feature do
  before :each do
    @user1 = User.create!(email: 'furkan@gmail.com', password: '123456',
                          name: 'furkan', bio: 'furkan\'s bio...',
                          photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80')

    @user2 = User.create!(email: 'parker@gmail.com', password: 'abcdef',
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
    @post4 = @user1.posts.create!(title: 'test_4', text: 'Test cases 4', comments_counter: 0, likes_counter: 0,
                                  user_id: @user1.id)

    @post1.comments.create!(text: 'comment 1 from user 1', author: @user1)
    @post1.comments.create!(text: 'comment 2 from user 1', author: @user2)
    @post1.comments.create!(text: 'comment 3 from user 2', author: @user2)
    @post1.comments.create!(text: 'comment 4 from user 2', author: @user2)

    @post1.likes.create!(user_id: @user2)
    @post1.likes.create!(user_id: @user1)

    visit user_post_path(@user1, @post1)
  end

  it "should see the post's title" do
    expect(page).to have_content('test_1')
  end

  # it 'should see who wrote the post' do
  #   expect(page).to have_content('furkan')
  # end

  # it 'should see how many comments it has' do
  #   expect(page).to have_content('Comments: 4')
  # end

  # it 'should see how many likes it has' do
  #   expect(page).to have_content('Likes: 2')
  # end

  # it 'should see the post body' do
  #   expect(page).to have_content('Test cases 1')
  # end

  # it 'should see the username of each commentor' do
  #   expect(page).to have_content('furkan')
  #   expect(page).to have_content('parker')
  # end

  # it 'should see the comment each commentor left' do
  #   expect(page).to have_content('comment 1 from user 1')
  #   expect(page).to have_content('comment 2 from user 1')
  #   expect(page).to have_content('comment 3 from user 2')
  #   expect(page).to have_content('comment 4 from user 2')
  # end
end
