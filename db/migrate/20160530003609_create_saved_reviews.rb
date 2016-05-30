class CreateSavedReviews < ActiveRecord::Migration
  def change
    create_table :saved_reviews do |t|
      t.references :user, index: true, foreign_key: true
      t.references :review, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :saved_reviews, [:user_id, :created_at]
  end
end
