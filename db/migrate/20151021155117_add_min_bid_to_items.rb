class AddMinBidToItems < ActiveRecord::Migration
  def change
    add_column :items, :min_bid, :decimal, precision: 5, scale: 2
  end
end
