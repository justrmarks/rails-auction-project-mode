class SalesController < ApplicationController
  # Before showing, editing, or updating a Sale, look them up.
  before_action :get_sale, only: [:show, :edit, :update]

  # Gets a view with all Sales on it.
  # GET /sales
  def index
    @sales = Sale.all
    @bid = Bid.new
  end

  # Gets a view containing the Sale with given :id.
  # GET /sales/:id
  def show
  end

  # Gets a view containing a form to create a new Sale.
  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # Creates a new Sale and saves it to the database with the given params.
  # POST /sales
  def create
    @sale = Sale.new(sale_params.merge(seller_id: session[:user_id], owner_id: session[:user_id], active: true))
    if @sale.save
      redirect_to root_path, notice: "Sale successfully created!"
    else
      redirect_to new_sale_path, alert: "One or more of the fields were filled out incorrectly."
    end
  end

  private
    # Get the Sale associated with :id.
    def get_sale
      @sale = Sale.find(params[:id])
    end

    # Censor the params to make sure no bad guys take control of our app.
    def sale_params
      params.require(:sale).permit(:name, :description, :price, :closing_date)
    end
end
