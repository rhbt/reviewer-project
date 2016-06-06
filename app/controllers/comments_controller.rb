class CommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  before_action :able_to_comment, only: [:create]
  
  def create 
    @comment = current_user.comments.create(comment_params)
    
    if @comment.save
      current_user.update_attribute(:last_comment, Time.zone.now)
      flash[:success] = "Comment created"
    else
      flash[:danger] = comment_validation(params[:comment][:content])
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
      params.require(:comment).permit(:user_id, :review_id, :content)
    end
  
    def able_to_comment
      if current_user.last_comment > 60.seconds.ago
        flash[:danger] = "You must wait 60 seconds between comments"
        redirect_to request.referer || current_user
      end
    end
  
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end   
    
    def comment_validation(comment)
      comment.length < 10 ? "Your comment is too short, comments must be at least 10 characters long" 
      : "Error creating comment, try again"
    end
  
end

