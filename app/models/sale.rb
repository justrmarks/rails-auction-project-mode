class Sale < ApplicationRecord
  # Buyer/seller relationship.
  belongs_to :seller, :foreign_key => "seller_id", :class_name => "User"
  has_one :buyer, :foreign_key => "buyer_id", :class_name => "User"
  has_many :offers
  # What is being sold.
  # Auction bids.
  # has_many :offers
  delegate :username, prefix: "seller", to: :seller

  def hours_until_close
    (self.closing_date.to_time - DateTime.now.to_time) / 1.hours
  end


  # Methods
  # def get_highest_offer
  #   self.offers.max_by {|offer| offer.amount}
  # end
  #
  # def close_sale
  # end
  #
  #
  # def self.get_average_bid(item)
  # end






end
