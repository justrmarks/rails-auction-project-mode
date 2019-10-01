class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :sale

  delegate :username, :to => :user
end
