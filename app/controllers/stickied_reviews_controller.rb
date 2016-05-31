class StickiedReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  
  def create
    review_id = params[:review_id]
    if already_saved?(review_id)
      current_user.stickied_reviews.create(review_id: review_id)
      flash[:success] = "Review saved successfully!"
      redirect_to current_user
    else 
      redirect_to root_path
    end
  end

  def destroy
    review_id = params[:review_id]
    if !already_saved?(review_id)
      current_user.stickied_reviews.find_by(review_id: review_id).destroy
      flash[:success] = "Review deleted"
      redirect_to current_user
    else
      redirect_to root_path
    end
  end
  
  private
  
  def already_saved?(review_id)
    current_user.stickied_reviews.find_by(review_id: review_id).nil?
  end
  
end
