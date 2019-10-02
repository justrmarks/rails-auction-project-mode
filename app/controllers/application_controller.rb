class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  
  # Checks if a user is logged in.
  def logged_in?
    !!session[:user_id]
  end

  # Gets the current User if a user is logged in with :user_id.
  def current_user
    logged_in? ? User.find(session[:user_id]) : nil
  end
end
