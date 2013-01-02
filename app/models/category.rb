class Category < ActiveRecord::Base
	
	has_ancestry
	has_and_belongs_to_many :classifieds

	before_save :set_identifier

	validates :name, uniqueness: :true

	def to_param
		identifier
	end

	def set_identifier
		self.identifier = self.name.parameterize
	end
end
