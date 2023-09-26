class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'user_id'
  has_many :likes, foreign_key: 'user_id'
  # validations: name must not be blank
  validates :name, presence: true
  # PostsCounter must be an integer greater than or equal to zero
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
end
