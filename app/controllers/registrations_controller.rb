class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_in_path_for(users)
    flash[:notice] = 'Welcome! Please follow the steps!'
    
    redirect_to posts_path
  end

end