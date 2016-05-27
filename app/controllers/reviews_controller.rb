class ReviewsController < ApplicationController
  require "net/http"


  def index
    review = Review.find_by(url: params[:search])
    if review
      redirect_to review
    else
      flash[:danger] = "Review for this classified ad does not exist!"
      redirect_to root_path
    end
  end
  
  def show
    @review = Review.find(params[:id])
    if @review
      
    else
      
    end
  end
  
  def new
    @new_review = Review.new
  end

  def create
    @new_review = Review.new(review_params)
    
    if @new_review.save
      redirect_to root_path
    else 
      render 'new'
    end
  end

  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit(:url, :content)
  end

end

