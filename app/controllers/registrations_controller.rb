class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_in_path_for(posts)
    #flash[:notice] = 'Welcome! Please follow the steps!'
    case resource
    when :user, User
      resource.teacher? ? another_path : root_path
    else
      super
    end
    #redirect_to posts_path
  end
  def after_sign_up_path_for(posts)
    #flash[:notice] = 'Welcome! Please follow the steps!'
    case resource
    when :user, User
      root_path
    else
      super
    end
    #redirect_to posts_path
  end
end