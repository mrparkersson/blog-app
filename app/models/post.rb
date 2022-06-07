class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_post_counter

  private

  def update_posts_counter
    author.increment!(:PostsCounter)
  end

  def return_five_most_recent_comments
    comments.order('created_at DESC').limit(5)
  end
end
