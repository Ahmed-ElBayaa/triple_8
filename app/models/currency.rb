class Currency < ActiveRecord::Base
	has_many :classifieds

	belongs_to :country
end
