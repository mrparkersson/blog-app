class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { greater_than_or_equal_to: 0 }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :author, class_name: 'User'

  def recent_5_comments
    comments.order('created_at Desc').limit(5)
  end

  # after_save :update_posts_counter

  # private

  def update_posts_counter
    User.increment_counter(:posts_counter, author_id)
  end
end
