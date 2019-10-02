class User < ApplicationRecord
  # A User has a username/password. A User's username is unique.
  has_secure_password
  validates :username, presence: true, uniqueness: true
  has_many :sales, foreign_key: "seller_id", class_name: "Sale"  # get_sales_as_seller
  has_many :bids # get_sales_as_bidder


  # get_closed_sales_as_seller

  def open_bid_sales
    self.bids.map {|bid| bid.sale}.select {|sale| sale.active}
  end

  def open_sales
    self.sales.select {|sale| sale.active }
  end

  def won_sales
    Sale.all.select do |sale|
      !sale.active &&
      sale.owner_id == self.id &&
      sale.owner_id != sale.seller_id
    end
  end

  def 
  end


end
