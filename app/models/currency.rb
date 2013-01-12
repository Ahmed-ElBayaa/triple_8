class Currency < ActiveRecord::Base
	has_many :classifieds

	belongs_to :country

	validates :unit, :ratio, :country, presence: true
end
