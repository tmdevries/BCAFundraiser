class StaticController < ApplicationController
  def index
  	@items = Auction.joins(:items).where('active'=>true)
  end
end
