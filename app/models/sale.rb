class Sale < ApplicationRecord
  # Buyer/seller relationship.
  belongs_to :seller, :foreign_key => "seller_id", :class_name => "User"
  has_one :buyer, :foreign_key => "buyer_id", :class_name => "User"
  has_many :offers
  # What is being sold.
  # Auction bids.
  # has_many :offers
  delegate :username, prefix: "seller", to: :seller


  # Methods
  # def get_highest_offer
  #   self.offers
  # end
  #
  # def close_sale
  # end
  #
  #
  # def self.get_average_bid(item)
  # end






end
