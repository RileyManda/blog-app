class CreateComment < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.text :text
      t.datetime :updated_at
      t.datetime :created_at
      t.timestamps
    end
  end
end
