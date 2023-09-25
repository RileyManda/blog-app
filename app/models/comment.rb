class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'

  def increment_post_comments_counter
    post.update(comments_counter: post.comments_counter + 1)
  end

  def decrement_post_comments_counter
    post.update(comments_counter: post.comments_counter - 1)
  end
end
