class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :user_id, :post_id
  belongs_to :post, class_name: 'post', foreign_key: 'post_id'
  belongs_to :user, class_name: 'user', foreign_key: 'user_id'
end
