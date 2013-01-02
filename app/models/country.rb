class Country < ActiveRecord::Base

	attr_accessible :name, :short_name,:flag
	has_attached_file :flag, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	before_save :set_identifier

	validates :name, uniqueness: :true

	def to_param
		identifier
	end

	def set_identifier
		self.identifier = self.name.parameterize
	end
end
