class Category < ActiveRecord::Base
	has_ancestry
	before_save :set_identifier

	def to_param
		identifier
	end

	def set_identifier
		self.identifier = self.name.parameterize
	end
end
