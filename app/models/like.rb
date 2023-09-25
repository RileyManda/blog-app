class Like < ApplicationRecord
  belongs_to :post, class_name: 'Post'
  belongs_to :user, class_name: 'User'

  def update_likes_counter
    post.update(likes_count: post.likes.count)
  end
end
