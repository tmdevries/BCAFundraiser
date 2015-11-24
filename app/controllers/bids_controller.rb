class BidsController < ApplicationController
  before_action :logged_in, only: [:new, :create, :destroy]
  before_action :set_bid, only: [:destroy]
  before_action :authorize, only: [:destroy]

  def index
    @items_join = Item.joins(:auction).where(auctions: {active: true})
    @bids_join = Bid.joins(item: :auction).where(auctions: {active: true})
    #byebug
  end

  # GET /bids/new
  def new
    item = Item.find(params[:item_id])
    @bid = item.bids.build
  end

  # POST /bids
  # POST /bids.json
  def create
    item = Item.find(params[:item_id])
    if item.bids.present? && User.find(Bid.where(:item_id => item.id).order('bid_amount').reverse.first.user_id).notify_by_email
      outbid_user = User.find(Bid.where(:item_id => item.id).order('bid_amount').reverse.first.user_id)
    else
      outbid_user = nil
    end
    @bid = item.bids.create(bid_params)
    @bid.set_user!(current_user.id)
    respond_to do |format|
      if @bid.save
        item.update(:min_bid => @bid.bid_amount)
        UserMailer.outbid_email(outbid_user, item).deliver_now unless outbid_user.nil?
        # UserMailer.outbid_text(outbid_user, item).deliver_now
        flash[:success] = 'Bid was successfully submited. Thank you and good luck!'
        format.html { redirect_to item }
        format.json { render :show, status: :created, location: @bid }
      else
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  # def update
  #   respond_to do |format|
  #     if @bid.update(bid_params)
  #       flash[:info] = 'Bid was successfully updated.'
  #       format.html { redirect_to @bid }
  #       format.json { render :show, status: :ok, location: @bid }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @bid.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    item = Item.find(@bid.item_id)
    @bid.destroy
    respond_to do |format|
      if item.bids.count==0
        item.update(:min_bid => item.starting_bid)
      else
        new_min_bid = Bid.where(:item_id => item.id).order('bid_amount').reverse.first.bid_amount
        item.update(:min_bid => new_min_bid)
      end
      flash[:info] =  'Bid was successfully deleted.'
      format.html { redirect_to bids_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    def logged_in
      unless logged_in?
        flash[:warning] = "Please log in!"
        redirect_to login_url
      end
    end

    def authorize
      unless admin?
        flash[:danger] = 'You are not authorized to access this part of the site!'
        redirect_to(root_url) 
      end
    end

    def highest_bid(item)
      return top_bid(item)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:bid_amount, :user_id)
    end
end
