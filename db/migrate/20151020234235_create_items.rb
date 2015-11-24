class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_title
      t.string :item_description
      t.decimal :item_value, :decimal, precision: 5, scale: 2, :null => false, :default => 0
      t.decimal :min_increase, :decimal, precision: 5, scale: 2, :null => false, :default => 0
      t.decimal :starting_bid, :decimal, precision: 5, scale: 2, :null => false, :default => 0
      t.string :donor_name
      t.boolean :donor_visible
      t.references :auction, index: true, foreign_key: true
    end
  end
end
