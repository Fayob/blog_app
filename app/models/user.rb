class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: :author_id

  # before_validation :set_defaults, on: :create
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def recent_three_posts
    posts.order(created_at: :desc).limit(3)
  end

  # private

  # def set_defaults
  #   posts_counter = 0
  # end
end
