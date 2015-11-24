module ItemsHelper
  def top_bid(item)
  	item.bids.order('bid_amount').reverse.first
  end
end
