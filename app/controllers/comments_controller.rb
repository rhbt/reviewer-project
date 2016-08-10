class CommentsController < ApplicationController
  before_action :correct_user, only: [:destroy, :update]
  before_action :able_to_comment, only: [:create]
  
  def create 
    @comment = current_user.comments.create(comment_params)
    @review = Review.find_by(id: params[:comment][:review_id])
  


    if @comment.save
      current_user.update_attribute(:last_comment, Time.zone.now)
      @review.increment!(:total_ratings)
      @review.update_attribute(:rating, @review.rating + @comment.rating)

    else
        flash[:error] = @comment.errors.full_messages
    end
    
    respond_to do |format|
      format.html { redirect_to request.referer || review_path(params[:review_id]) }
      format.js
    end

  end
  
  def update

    
    if @comment.update_attributes(comment_params)
      respond_to do |format|
        format.html { 
          flash[:success] = "Comment updated!"
          redirect_to request.referer }
        format.js { render "update.js.erb"}
      end
      
    else
      respond_to do |format|
        format.html { 
          flash[:error] = @comment.errors.full_messages
          redirect_to request.referer }
        format.js { render "update.js.erb" }
      
      end
    end
  end
  
  def destroy
    @review = Review.find_by(id: @comment.review_id)
    @review.update_attributes(total_ratings: @review.total_ratings - 1, rating: @review.rating - @comment.rating)
    @comment.destroy
    
    respond_to do |format|
      format.html { redirect_to request.referer || review_path(params[:review_id]) }
      format.js
    end
    
  end

  private

    def comment_params
      params.require(:comment).permit(:user_id, :review_id, :content, :rating)
    end
  
    def able_to_comment
      last_comment = current_user.last_comment
      if last_comment  > 30.seconds.ago
        
        @time_left = (last_comment - 30.seconds.ago).to_i
        
        
        respond_to do |format|
          format.html { 
            flash[:danger] = "You must wait #{@time_left} seconds before commenting again"
            redirect_to request.referer || current_user }
            
          format.js { render 'comment_time_error.js.erb' }
        end
        
      end
    end
  
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end   

end
  

