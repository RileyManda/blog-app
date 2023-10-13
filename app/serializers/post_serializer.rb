class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :bio, :likes_counter, :comments_counter, :author_id
  has_many :comments
  belongs_to :user, class_name: 'user', foreign_key: 'author_id'
end
