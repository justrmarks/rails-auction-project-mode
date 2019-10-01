class User < ApplicationRecord
  # A User has a username/password. A User's username is unique.
  has_secure_password
  validates :username, presence: true, uniqueness: true

  belongs_to :sale, :foreign_key => "buyer_id"
  # get_sales_as_seller
  # get_sales_as_bidder
  # get_closed_sales_as_seller
end
