class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'
  after_save :update_post_counter
  # Title must not be blank Title must not exceed 250 charactersr
  validates :title, presence: true, length: { maximum: 250 }
  # CommentsCounter must be an integer greater than or equal to zero.
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  private

  def update_post_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
