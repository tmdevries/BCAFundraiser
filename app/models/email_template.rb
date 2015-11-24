class EmailTemplate < ActiveRecord::Base
	ATTR_NAMES = {:alias => "Nickname"}

	def self.human_attribute_name(attr)
		ATTR_NAMES[attr.to_sym] || super
	end
end
