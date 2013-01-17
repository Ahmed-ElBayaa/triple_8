class Currency < ActiveRecord::Base
	has_many :classifieds

	belongs_to :country

	validates :name, :ratio, :country, presence: true
	validates :name, :uniqueness => {scope: :country_id}
end
