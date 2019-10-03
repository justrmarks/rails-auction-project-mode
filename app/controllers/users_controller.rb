class UsersController < ApplicationController
  # Before showing, editing, updating, or destroying a user, look them up.
  before_action :set_user, only: [:show, :edit, :update, :store]

  # Gets the show page for a User.
  # GET /users/:id
  def show
    if @user.id != current_user.id
      redirect_to store_users_path(@user)
    else
      @bidded_sales = @user.get_sales_as_bidder.sort_by {|sale| sale.bids.last.created_at}
    end
  end

  # Gets the page containing a form to create a new User.
  # GET /users/new
  def new
    @user = User.new
  end

  # Creates a new User with form input.
  # POST /
  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account succesfully created!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Account succesfully updated!"
    else
      render 'edit'
    end
  end

  def store
    @popular = @user.most_popular_sale
  end

  private
    # Finds a User based on the :id parameter passed to the route.
    def set_user
      @user = User.find(params[:id])
    end

    # Censor the params to make sure no bad guys take control of our app.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
