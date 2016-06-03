class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :review, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
    add_index :comments, [:review_id, :created_at]
    add_index :comments, [:user_id, :created_at]
  end
end
