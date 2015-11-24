class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.boolean :active
      t.date :event_date
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :amount_raised, precision: 5, scale: 2, :null => false, :default => 0
    end
  end
end
