class SalesController < ApplicationController

    def index
      @sales = Sale.all
    end

    def new
      @sale = Sale.new
      @items = Item.all
    end

    def create  
      @sale = Sale.new(sale_params)
      @sale.user_id = session[:user_id]
      if @sale.save
        redirect_to root_path
      else
        render :new
      end

    end

    def show
    end


    private
    def sale_params
      params.require(:sale).permit(:item_id, :price, :closing_date)
    end
    
end
