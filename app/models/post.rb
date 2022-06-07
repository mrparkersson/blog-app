class Post < ApplicationRecord
  belongs_to :user

  def update_posts_counter
    author.increment!(:PostsCounter)
  end

  def return_five_most_recent_comments
    comments.order('created_at DESC').limit(5)
  end
end
