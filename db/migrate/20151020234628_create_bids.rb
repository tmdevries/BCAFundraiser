class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :bid_amount
      t.references :user, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
    end
  end
end
