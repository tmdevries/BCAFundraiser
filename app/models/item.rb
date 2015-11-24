class Item < ActiveRecord::Base
  belongs_to :auction
  has_many :bids
  has_attached_file :image

  validates :item_title, presence: true;
  validates :item_value, presence: true;
  validates :starting_bid, presence: true;
  validates :min_increase, presence: true;
  validates_attachment :image, :content_type => { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    :size => { :in => 0..150.kilobytes }

  def item_value=(val)
    currency = val.to_s.gsub(/[-$,]/,'').to_f if val.present?
    write_attribute(:item_value, currency)
  end

  def starting_bid=(val)
    currency = val.to_s.gsub(/[-$,]/,'').to_f if val.present?
    write_attribute(:starting_bid, currency)
    write_attribute(:min_bid, currency)
  end

  def min_increase=(val)
    currency = val.to_s.gsub(/[-$,]/,'').to_f if val.present?
    write_attribute(:min_increase, currency)
  end

end
