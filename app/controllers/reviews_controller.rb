class ReviewsController < ApplicationController
  #only allow 1 post per minute
  
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  before_action :able_to_review, only: [:create]
  
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
    @comment = current_user.comments.build
    @comments = @review.comments
  end
  
  def new
    @new_review = Review.new
  end

  def create
    @new_review = current_user.reviews.build(review_params)
    
    if @new_review.save
      current_user.update_attribute(:last_review, Time.zone.now)
      flash[:success] = "Review successfully created"
      redirect_to @new_review
    else 
      url = params[:review][:url]
      review = Review.find_by(url: url)
      if review
        flash[:success] = "Review already exists for the ad you were trying to review. Contribute your comments here!"
        redirect_to review
      else
        render 'new'
      end
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
  

    def able_to_review
      if current_user.last_review > 60.seconds.ago
        flash[:danger] = "You must wait 60 seconds between reviews"
        redirect_to new_review_path
      end
    end
 
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



