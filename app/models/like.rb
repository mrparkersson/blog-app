class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  def change
    rename_column :Comment, :user_id, :author_id
  end

  private

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
