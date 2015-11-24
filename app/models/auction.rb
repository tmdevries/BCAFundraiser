class Auction < ActiveRecord::Base
  has_many :items

  validates :event_date, presence: true

  ATTR_NAMES = {:start_date => "Start date and time",
                :end_date   => "End date and time"}

  def event_date=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute(:event_date, date)
  end

  def start_date=(val)
    date = DateTime.strptime(val, "%m/%d/%Y %l:%M %p") if val.present?
    write_attribute(:start_date, date)
  end

  def end_date=(val)
    date = DateTime.strptime(val, "%m/%d/%Y %l:%M %p") if val.present?
    write_attribute(:end_date, date)
  end

  def amount_raised=(val)
    currency = val.to_s.gsub(/[-$,]/,'').to_f if val.present?
    write_attribute(:amount_raised, currency)
  end

  def self.human_attribute_name(attr)
    ATTR_NAMES[attr.to_sym] || super
  end
end
