class CommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  before_action :able_to_comment, only: [:create]
  
  def create 
    @comment = current_user.comments.create(comment_params)
    @review = Review.find_by(id: params[:comment][:review_id])
    
    if @comment.save
      current_user.update_attribute(:last_comment, Time.zone.now)
      flash[:success] = "Comment created"
      @review.increment!(:total_ratings)
      @review.update_attribute(:rating, @review.rating + @comment.rating)
      
    else
        flash[:error] = @comment.errors.full_messages
    end
      redirect_to request.referer || review_path(params[:review_id])
  end
  
  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referer || review_path(params[:review_id])
  end

  private

    def comment_params
      params.require(:comment).permit(:user_id, :review_id, :content, :rating)
    end
  
    def able_to_comment
      if current_user.last_comment > 45.seconds.ago
        flash[:danger] = "You must wait 45 seconds between comments"
        redirect_to request.referer || current_user
      end
    end
  
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end   

end

