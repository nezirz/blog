class ContactController < ApplicationController
  def index
  	if user_signed_in?
      @recentposts = Post.where("user_id==#{current_user.id}").last(5).reverse
      @recentcomments = Comment.where("user_id==#{current_user.id}").last(5).reverse  	
   end
  end
end
