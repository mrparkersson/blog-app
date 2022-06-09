class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, numericality: { greater_than_or_equal_to: 0 }
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_post_counter

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def return_five_most_recent_comments
    comments.order('created_at DESC').limit(5)
  end
end
