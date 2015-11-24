class Bid < ActiveRecord::Base
  belongs_to :item

  before_save :valid_bid?

  validates :bid_amount, presence: true;

  def bid_amount=(val)
    currency = val.to_s.gsub(/[-$,]/,'').to_f if val.present?
    write_attribute(:bid_amount, currency)
  end

  # "top bid" ends up being the current bid tmeporarily before the data is 
  # actually saved. This is the motivation for the min_bid column in :items
  def valid_bid?
    unless Auction.find(Item.find(self.item_id).auction_id).end_date > (DateTime.now.to_time - 7.hours).to_datetime
      errors[:base] = "It is now past the auction time and no more bids are allowed online."
      return false
    end
    # Check if there are any bids for this item yet.
    if !Bid.where(:item_id => self.item_id).empty?
      # Checks if there was an unsuccessful bid that is waiting but it's the first one
      if Bid.where(:item_id => self.item_id).count == 1 && Bid.where(:item_id => self.item_id).first.user_id.nil?
        if self.bid_amount >= Item.find(self.item_id).min_bid
          return true
        else 
          errors[:base] = "Invalid bid amount! Please make sure that your bid is at 
          least as high as the starting bid."
          return false
        end
      end
      # Check that this bidder is not the one who made the highest bid, first
      if Bid.where(:item_id => self.item_id, :bid_amount => Item.find(self.item_id).min_bid).first.user_id==self.user_id
      	errors[:base] = "You are already the highest bidder!"
        return false
      else
        # Now check that this bid amount is higher than the highest bid amount
        if self.bid_amount < Item.find(self.item_id).min_bid + Item.find(self.item_id).min_increase
          errors[:base] = "Invalid bid amount! Please make sure that your bid is at 
          least as high as the highest bid plus the minimum increase."
          return false
        else
          # If the bidder isn't already the highest bidder, the bid amount is not empty,
          # and the bid is more than the highest bid, return true because it's valid
          return true
        end
      end
    # there are no bids for the item, check that the bid is at least as much as the min bid
    else
      if self.bid_amount >= Item.find(self.item_id).min_bid
        return true
      else 
        errors[:base] = "Invalid bid amount! Please make sure that your bid is at 
        least as high as the starting bid."
        return false
      end
    end
  end

  def set_user!(val)
  	write_attribute(:user_id, val)
  end
end