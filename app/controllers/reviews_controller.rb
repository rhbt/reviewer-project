class ReviewsController < ApplicationController
  #only allow 1 post per minute
  
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
    review = Review.find_by(url: format_url(params[:search]))
    if review
      redirect_to review
    else
      flash[:danger] = "Review for this classified ad does not exist!"
      redirect_to root_path
    end
  end
  
  def show
    @review = Review.find(params[:id])
    @author = @review.user
  end
  
  def new
    @new_review = Review.new
  end

  def create
    @new_review = current_user.reviews.build(review_params)
    
    if @new_review.save
      flash[:success] = "Review successfully created"
      redirect_to @new_review
    else 
      render 'new'
    end
  end

  def destroy
    @review.destroy
    flash[:success] = "Micropost deleted"
    redirect_to root_url
  end

  def format_url(url)
    pos = url =~ /:\/\//
    url =~ /\Ahttps?:\/\//? url = url[pos+3..-1].downcase : url
  end
  

  
  private
 
    def review_params
      params.require(:review).permit(:url, :content)
    end
    
    def correct_user
      @review = Review.find(params[:id])
      if current_user.id != @review.user_id
        redirect_to root_url
      end
    end    
  
end



