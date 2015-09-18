class PostsController < ApplicationController
  before_action :authenticate_user! , except: [:index]
  
  def index
    @posts = Post.all.reverse 

    @recentposts = Post.last(5).reverse
    @recentcomments = Comment.last(5).reverse
  end

  def show
    @post = Post.find(params[:id])

    @posts=Post.all.reverse 
    @recentposts = @posts.last(5)
    @recentcomments = Comment.last(5).reverse
  end

  def new
    @post = Post.new

    @posts=Post.all.reverse 
    @recentposts = Post.last(5).reverse
    @recentcomments = Comment.last(5).reverse
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
    params.require(:post).permit(:title, :body)
  end
end
