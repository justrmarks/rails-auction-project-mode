class Sale < ApplicationRecord
  # Buyer/seller relationship.
  belongs_to :seller, :foreign_key => "seller_id", :class_name => "User"
  belongs_to :owner, :foreign_key => "owner_id", :class_name => "User"
  # has_many :offers
  # What is being sold.
  # Auction bids.
  has_many :bids
  delegate :username, prefix: "seller", to: :seller

  after_find do |sale|
    if sale.closing_date < Time.zone.now
      sale.close_sale
    end
  end

  def get_highest_bid
    self.bids.max_by {|bid| bid.amount}
  end

  def close_sale
    winning_bid = get_highest_bid
    if winning_bid 
      winner = winning_bid.user
      self.active = false
      if winner
        self.owner = winner
      end
      self.save
    end
  end

  def hours_until_close
    (self.closing_date.to_time - Time.zone.now.to_time) / 1.hours
  end

  def format_time 
 
    timeElapsed = hours_until_close * 3600
    minutes = (timeElapsed / 60) % 60
    hours = (timeElapsed/3600)
 
    hours.round.to_s + ":" + format("%02d",minutes.round.to_s)
  end


end
