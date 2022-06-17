class User < ApplicationRecord
  attr_writer :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true
  validates_format_of :name, with: /^[a-zA-Z0-9_.]*$/, multiline: true

  def most_recent_post
    Post.order('created_at DESC').where(author_id: id).limit(3)
  end

  def admin?
    role == 'admin'
  end
end
