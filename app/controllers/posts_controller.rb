class PostsController < ApplicationController
  before_action :authenticate_user! , except: [:index,:show]
  
  def index
    if user_signed_in?
      @posts = Post.where("user_id==#{current_user.id}").reverse 

      @recentposts = Post.where("user_id==#{current_user.id}").last(5).reverse
      @recentcomments = Comment.where("user_id==#{current_user.id}").last(5).reverse
     
    else

      @posts = Post.all.reverse 

      @recentposts = Post.last(5).reverse
      @recentcomments = Comment.last(5).reverse 
    end

  end

  def show
    @post = Post.find(params[:id])

    if user_signed_in?

      @recentposts = Post.where("user_id==#{current_user.id}").last(5).reverse
      @recentcomments = Comment.where("user_id==#{current_user.id}").last(5).reverse
     
    else

      @recentposts = Post.last(5).reverse
      @recentcomments = Comment.last(5).reverse 
    end
  end

  def new
    @post = Post.new

      if user_signed_in?
        @posts = Post.where("user_id==#{current_user.id}").reverse 

        @recentposts = Post.where("user_id==#{current_user.id}").last(5).reverse
        @recentcomments = Comment.where("user_id==#{current_user.id}").last(5).reverse
       
      else

        @posts = Post.all.reverse 

        @recentposts = Post.last(5).reverse
        @recentcomments = Comment.last(5).reverse 
      end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id=current_user.id   
    
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id=current_user.id
    
    if @post.save
      redirect_to @post
    else
      render 'new'
    end

  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :photo)
  end
end
