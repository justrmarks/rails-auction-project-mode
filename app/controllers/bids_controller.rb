class BidsController < ApplicationController

  def create
      @sale =  Sale.find(params[:sale_id])
    	@bid = Bid.new(bid_params)
      @bid.user_id = current_user.id
      @bid.sale_id = @sale.id
      
      if @sale.closing_date - Time.now >0
        @sale.price = @sale.price + @bid.amount
        if @bid.save
          @sale.save
          redirect_to root_path, :notice => "Bid was successfully placed." 
        else
          redirect_to root_path, :notice => "Please enter a valid amount."
        end
      else
        redirect_to root_path, :notice => 'The auction has ended.'
      end
  end

  private

  def bid_params
    params.permit(:amount)
  end

end
