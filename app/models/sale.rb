class Sale < ApplicationRecord
  # Buyer/seller relationship. The owner will start as the seller, and once
  # a Sale is complete, the owner will transition to be the buyer.
  belongs_to :seller, :foreign_key => "seller_id", :class_name => "User"
  belongs_to :owner, :foreign_key => "owner_id", :class_name => "User"

  # A Sale can receive many bids.
  has_many :bids

  # ActiveStorage
  has_one_attached :img

  # Return a Sale's seller's name.
  delegate :username, prefix: "seller", to: :seller
  validates :name, presence: true
  validates :description, presence: true, length: {maximum: 1000,
    too_long: "1000 characters is the maximum allowed"}
  validates :price, presence: true


  # A callback on Sale access that checks whether or not a Sale should be closed.
  after_find do |sale|
    if sale.closing_date < Time.zone.now
      sale.close_sale
    end
  end

  # Used by the after_find callback. Closes a Sale.
  def close_sale
    self.active = false
    if winner?
      self.owner = winner?
      self.save
    end
  end

  # Get the last num Bids made on this Sale.
  def get_recent_bids(num)
    self.bids.sort_by {|bid| bid.created_at}.last(num)
  end

  # Returns the last Bid made on this Sale.
  def get_last_bid
    self.bids.max_by {|bid| bid.created_at}
  end

  # Determines the winner by the last Bid made.
  def winner?
    !!get_last_bid ? get_last_bid.user : nil
  end

  # Determines the current bid on the object.
  def current_asking_price
    !!get_last_bid ? get_last_bid.amount : self.price
  end

  # Returns a string representation of the Sale's closing date.
  def get_closing_date
    self.closing_date.strftime("%m/%d/%Y")
  end

  # Returns a string representation of the time remaining until the Sale closes.
  def time_to_close
    timeElapsed = hours_until_close * 3600
    minutes = (timeElapsed / 60) % 60
    hours = (timeElapsed/3600)
    hours.round.to_s + ":" + format("%02d",minutes.round.to_s)
  end

  # Gets the hours until closing time.
  def hours_until_close
    (self.closing_date.to_time - Time.zone.now.to_time) / 1.hours
  end

  # Get a list of Sales that are still active.
  def self.get_open_sales
    Sale.all.select {|sale| sale.active}
  end

  # Get a list of Sales that are no longer active.
  def self.get_closed_sales
    Sale.all.select {|sale| !sale.active}
  end

  # Get a list of open Sales created by seller with id user_id.
  def self.get_open_sales_by_seller(user_id)
    self.get_open_sales.select {|sale| sale.seller_id == user_id}
  end

  # Get a list of closed Sales created by seller with id user_id.
  def self.get_closed_sales_by_seller(user_id)
    self.get_closed_sales.select {|sale| sale.seller_id == user_id}
  end

  def self.search(search)
    if search && search.length > 0
      sale = Sale.get_open_sales.select {|sale| sale.name.downcase.include? search.downcase }
    else
      Sale.get_open_sales
    end
  end

  # returns list of increment amounts relative to current asking price
  def get_bid_increments
    result = [
      self.current_asking_price * 0.1,
      self.current_asking_price * 0.2,
      self.current_asking_price * 0.4,
      self.current_asking_price * 0.6
    ]
    return result.map {|num| num.round(2)}
  end

end
