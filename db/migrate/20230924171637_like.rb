class CreateLike < ActiveRecord::Migration[7.0]
def change
    create_table :like do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.datetime :created_at
      t.datetime :updated_at
      t.timestamps
    end
  end
end