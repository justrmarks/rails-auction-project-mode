class SessionsController < ApplicationController
  # Renders the show page for a new session.
  def new
  end

  # Populates session with a :user_id from the login page.
  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Successfully logged in!"
    else 
      redirect_to login_path, alert: "Email or password is invalid"
    end
  end

  # Sets session[:user_id] to nil.
  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: "Logged out!"
  end
end
