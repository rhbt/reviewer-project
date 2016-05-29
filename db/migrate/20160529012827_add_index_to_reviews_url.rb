class AddIndexToReviewsUrl < ActiveRecord::Migration
  def change
    add_index :reviews, :url, unique: true
  end
end
