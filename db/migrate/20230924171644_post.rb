class CreatePost < ActiveRecord::Migration[7.0]
  def change
     create_table :post do |t|
      t.references :author_id,
      t.references :user, foreign_key: true
      t.string :title
      t.text :text
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :comments_counter, default: 0
      t.integer :likes_counter, default: 0
      t.timestamps
  end
end
