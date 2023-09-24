class CreateLike < ActiveRecord::Migration[7.0]
def change
    create_table :like do |t|
      t.references :user_id,
      t.references :post_id, foreign_key: true
      t.datetime :created_at
      t.datetime :updated_at
      t.timestamps
    end
  end
end