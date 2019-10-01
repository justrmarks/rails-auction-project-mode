class Sale < ApplicationRecord
  # Buyer/seller relationship.
  belongs_to :seller, :foreign_key => "seller_id", :class_name => "User"
  has_one :buyer, :foreign_key => "buyer_id", :class_name => "User"
  # has_many :offers
  # What is being sold.
  # Auction bids.
  has_many :bids
  delegate :username, prefix: "seller", to: :seller

  after_find do |sale|
    if sale.closing_date.to_time - DateTime.today.to_time < 0
      sale.close_sale
    end
  end

  def get_highest_bidder
    self.bids.max_by {|bid| bid.amount}
  end

  def close_sale
    winner = get_highest_bidder.user
    self.active = false
    if winner
      self.buyer = winner
    end
    self.save
  end











end
