class User < ApplicationRecord
  # A User has a username/password. A User's username is unique.
  has_secure_password
  validates :username, presence: true, uniqueness: true
  # A User that is a seller has many sales.
  has_many :sales, foreign_key: "seller_id", class_name: "Sale"
  # A User that is a buyer has many bids.
  has_many :bids

  # Get a list of the Sales a Buyer has Bid on.
  def get_sales_as_bidder
    self.bids.map {|bid| bid.sale}.select {|sale| sale.active}.uniq
  end

  # Get a list of the Sales a Seller has posted.
  def open_sales
    self.sales.select {|sale| sale.active }
  end

  # Get a list of a Seller's Sales that found a buyer.
  def get_successful_sales
    self.sales.select {|sale| !sale.active && sale.owner_id != self.id}
  end

  # Get a list of the Sales whose auction a Buyer won.
  def won_sales
    Sale.all.select {|sale| !sale.active && sale.owner_id == self.id && self.id != sale.seller_id}
  end

  # Gets the total revenue a Seller has made from successful Sales.
  def get_total_revenue
    self.get_successful_sales.sum {|sale| sale.get_last_bid.amount}
  end

  # Gets the success rate of a Seller's Sales.
  def sale_success_rate
    self.get_successful_sales.count.to_f / self.sales.count
  end

  # Get the Seller's Sale that received the most Bids.
  def most_popular_sale
    self.get_successful_sales.max_by {|sale| sale.bids.count}
  end

  # Get a list of the Seller's Sales that were not Bid on.
  def get_unsuccessful_sales
    (self.sales - self.get_successful_sales).select {|sale| !sale.active}
  end
end
