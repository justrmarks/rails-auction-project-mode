class User < ApplicationRecord
  # A User has a username/password. A User's username is unique.
  has_secure_password
  validates :username, presence: true, uniqueness: true
end
