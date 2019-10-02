class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :sale

  delegate :username, :to => :user

  # Return a formatted string representing the time that a Bid was placed.
  def get_time_placed
    self.created_at.strftime("%m/%d/%Y at %l:%M%p")
  end
end
