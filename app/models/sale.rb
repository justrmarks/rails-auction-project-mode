class Sale < ApplicationRecord
  # Buyer/seller relationship.
  belongs_to :seller, :foreign_key => "seller_id", :class_name => "User"
  has_one :buyer, :foreign_key => "buyer_id", :class_name => "User"
  # What is being sold.
  belongs_to :item
  # Auction bids.
  # has_many :offers

  # Method
  # get_highest_offer
  # self.get_average_bid(item)
  

end
