class ReviewsController < ApplicationController
require "net/http"

  def index
    review = Review.find_by(url: params[:search])
    if review
      redirect_to review
    else
      redirect_to root_path
    end
  end
  
  def show
    @review = Review.find(params[:id])
  end
  
  def new
    @new_review = Review.new
  end

  def create
    @new_review = Review.new(review_params)
    review_url = params[:review][:url]
    if valid_url(review_url) #&& @new_review.save 
      redirect_to root_path
      #redirect_to @new_review
    else 
      redirect_to new_review_path
    end
  end

  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit(:url, :content)
  end
  
  def valid_url(review_url)
    if !review_url.blank?
     url = URI.parse(review_url)
      req = Net::HTTP.new(url.host, url.port)
      res = req.request_head(url.path)
     if res.code == "200"
        true
     else
        false
     end
     false
    end
  end
  
end

