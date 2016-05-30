class StickiedReviewsController < ApplicationController
  before_action :logged_in_user
  
  def create
    review_id = params[:review_id]
    current_user.stickied_reviews.create(review_id: review_id)
    redirect_to root_url
  end

  def destroy
  end
  
end
