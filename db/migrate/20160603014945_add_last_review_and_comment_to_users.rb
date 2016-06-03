class AddLastReviewAndCommentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_review, :datetime
    add_column :users, :last_comment, :datetime
  end
end
