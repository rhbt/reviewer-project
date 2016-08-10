class AddItemToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :item, :string
  end
end
