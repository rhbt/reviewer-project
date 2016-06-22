class AddTotalRatingsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :total_ratings, :integer, default: 1
  end
end
