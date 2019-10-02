class BidsController < ApplicationController

  # Creates a new Bid with form input.
  # POST /
  def create
    @bid = Bid.new(bid_params)
    @sale = Sale.find(bid_params[:sale_id])
    @bid.user_id = current_user.id
      
    if @sale.active
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
    # Censor the params to make sure no bad guys take control of our app.
    def bid_params
      params.require(:bid).permit(:amount, :sale_id)
    end
end
