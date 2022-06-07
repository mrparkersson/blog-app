class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :author, class_name: 'User'

  def update_likes_counter
    post.increment!(:LikesCounter)
  end
end
