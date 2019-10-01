class BidsController < ApplicationController

  def new
    @bid = Bid.new
    # @sale =  Sale.find(params[:id])
  end

  def create
    	@bid = Bid.create(bid_params)
    	@bid.user_id = current_user.id
    	@user = @bid.user
  end

  private

  def bid_params
    params.permit(:bid).require(:bid, :user_id, :sale_id)
  end
  
end
