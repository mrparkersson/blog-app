class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  def change
    rename_column :Comment, :user_id, :author_id
  end

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
