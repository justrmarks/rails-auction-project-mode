class SalesController < ApplicationController
  before_action :get_sale, only: [:show, :edit, :update, :destroy]
    # Gets a view with all Sales on it.
    # GET /sales
    def index
      @sales = Sale.all
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
      @sale = Sale.new(sale_params)
      @sale.seller_id = session[:user_id]
      if @sale.save
        redirect_to root_path
      else
        render :new
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
