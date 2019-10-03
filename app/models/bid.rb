class Bid < ApplicationRecord
  # A Bid has a User that placed the bid and a Sale that it was placed on.
  belongs_to :user
  belongs_to :sale

  # Delegate the username function to retrieve a Bid's placer's username.
  delegate :username, :to => :user

  # Return a formatted string representing the time that a Bid was placed.
  def get_time_placed
    self.created_at.strftime("%m/%d/%Y at %l:%M%p")
  end
end
