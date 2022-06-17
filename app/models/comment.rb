class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author_id, class_name: 'User', optional: true

  def change
    rename_column :Comment, :user_id
  end

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
