class AdminPanelController < ApplicationController
  before_action :authorize, only: [:index]

  def index
  	@auctions = Auction.all
  end

  def email_bidders
    @templates = EmailTemplate.all
  end

  def send_email
  end

private 
  def authorize
    unless admin?
      flash[:danger] = 'You are not authorized to access this part of the site!'
      redirect_to(root_url) 
    end
  end
end
