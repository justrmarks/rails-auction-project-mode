class BidsController < ApplicationController

  def new
    @bid = Bid.new
    @sale =  Sale.find(params[:id])
  end

  def create
    	@bid = Bid.new(bid_params)
    	@bid.user_id = current_user.id
      @user = @bid.user
      
      if @sale.closing_date - Time.now >0
        @sale.price = @sale.price + @bid.bid

        respond_to do |format|
          if @bid.save
            @sale.save
            @user.save
            format.html {redirect_to :back, :notice => "Bid was succesfully placed." }
            format.json {render :json => @sale, :status=> :created, :location => @sale}
          else
            format.html {render :action => "new" }
            format.json {render :json => @bid.errors, :status => :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to :back, :notice => 'The auction has ended'}
          format,json { render :json => @bid.errors, :status => :unprocessable_entity }
        end
      end
  end

  private

  def bid_params
    params.permit(:bid).require(:bid, :user_id, :sale_id)
  end

end
