class User < ApplicationRecord
  # A User has a username/password. A User's username is unique.
  has_secure_password
  validates :username, presence: true, uniqueness: true
  # A User that is a seller has many sales.
  has_many :sales, foreign_key: "seller_id", class_name: "Sale"
  # A User that is a buyer has many bids.
  has_many :bids


  # get_closed_sales_as_seller
  def get_sales_as_bidder
    self.bids.map {|bid| bid.sale}.select {|sale| sale.active}.uniq
  end

  def open_sales
    self.sales.select {|sale| sale.active }
  end

  def get_successful_sales
    self.sales.select {|sale| !sale.active && sale.owner_id != self.id}
  end

  def won_sales
    Sale.all.select do |sale|
      !sale.active &&
      sale.owner_id == self.id &&
      sale.owner_id != sale.seller_id
    end
  end


  def get_total_revenue
    self.get_successful_sales.sum {|sale| sale.get_last_bid.amount}
  end

  def sale_success_rate
    self.get_successful_sales.count.to_f / self.sales.count
  end

  def most_popular_sale
    self.get_successful_sales.max_by {|sale| sale.bids.count}
  end

  def get_unsuccessful_sales
    (self.sales - self.get_successful_sales).select {|sale| !sale.active}
  end



end
