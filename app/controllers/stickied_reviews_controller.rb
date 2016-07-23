class StickiedReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    review_id = params[:review_id]
    
    if already_saved?(review_id)
      current_user.stickied_reviews.create(review_id: review_id)
      
      respond_to do |format|
        format.html { 
          flash[:success] = "Review saved successfully!"
          redirect_to request.referer || current_user }
          
        format.js { render 'save_review.js.erb'}
      end
      
    else 
      redirect_to root_path
    end
    
  end

  def destroy
    @review_id = params[:review_id]
    if !already_saved?(@review_id)
      current_user.stickied_reviews.find_by(review_id: @review_id).destroy
      
      
      
    respond_to do |format|
      format.html { 
        flash[:success] = "Review deleted"
        redirect_to request.referer || current_user }
        
      format.js { render 'destroy_saved_review.js.erb'}
    end
      
    else
      redirect_to root_path
    end
    
  end
  
  private
  
  def already_saved?(review_id)
    current_user.stickied_reviews.find_by(review_id: review_id).nil?
  end
  
end
