class ItemsController < ApplicationController
  before_action :logged_in, only: [:edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]


  # GET auctions/:auction_id/items
  def index
    auction = Auction.find(params[:auction_id])
    @items = auction.items
  end

  # GET /items/1
  def show
    @bids = @item.bids
  end

  # GET auctions/:auction_id/items/new
  def new
    auction = Auction.find(params[:auction_id])
    @item = auction.items.build
  end

  # GET /items/1/edit
  def edit
  end

  # POST auctions/:auction_id/items
  # POST auctions/:auction_id/items.json
  def create
    auction = Auction.find(params[:auction_id])
    @item = auction.items.create(item_params)

    respond_to do |format|
      if @item.save
        flash[:success] = 'Item was successfully created.'
        format.html { redirect_to @item }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        flash[:success] = 'Item was successfully updated.'
        format.html { redirect_to @item }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      flash[:info] = 'Item was successfully deleted.'
      format.html { redirect_to admin_panel_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:item_title, :item_description, :item_value, :donor_name, :donor_visible, :starting_bid, :min_bid, :min_increase, :image)
    end
end
