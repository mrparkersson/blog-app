class User < ApplicationRecord
  def most_recent_post
    Post.order('created_at DESC').where(author_id: id).limit(3)
  end
end
