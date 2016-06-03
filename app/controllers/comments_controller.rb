class CommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  before_action :able_to_comment, only: [:create]
  
  def create 
    params[:comment][:user_id] = params[:user_id]
    params[:comment][:review_id] = params[:review_id]
    @comment = current_user.comments.create(comment_params)
    if @comment.save
      current_user.update_attribute(:last_comment, Time.zone.now)
      flash[:success] = "Comment created"
      redirect_to review_path(params[:review_id])
    else
      flash[:danger] = "Comment not created user_id:#{params[:comment]}"
      redirect_to review_path(params[:review_id])
    end
  end
  
  def destroy
    review_id = @comment.review_id
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to review_path(review_id)
  end


  private
  
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
  
  def comment_params
    params.require(:comment).permit(:user_id, :review_id, :content)
  end
  
end

