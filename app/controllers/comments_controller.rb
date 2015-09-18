class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id #or whatever is you session name

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'show'
    end
  
  end

  def destroy
  	@post =Post.find(params[:post_id])
  	@comment = @post.comments.find(params[:id])
  	@comment.destroy

  	redirect_to post_path(@post)
  end
 
 private
 def comment_params
  	params.require(:comment).permit(:body,:user_id)
 end
end
