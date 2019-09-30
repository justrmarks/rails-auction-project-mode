class Item < ApplicationRecord
    has_many :sales
    
    # instance method
    # get_average_bid -> Sale.average_bid(self)
end
