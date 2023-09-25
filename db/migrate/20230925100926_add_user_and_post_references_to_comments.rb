class AddUserAndPostReferencesToComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user, foreign_key: true
    add_reference :comments, :post, foreign_key: true
  end
end