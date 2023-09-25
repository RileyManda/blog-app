class UpdatePostsForeignKey < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :posts, :users
    rename_column :posts, :user_id, :author_id
    add_foreign_key :posts, :users, column: :author_id  
  end
end
