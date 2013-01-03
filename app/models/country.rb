class Country < ActiveRecord::Base

	has_attached_file :flag, :styles => { :medium => "300x300>", :thumb => "100x100>" }

	before_save :set_identifier

	validates :name, uniqueness: :true
	validates_attachment_content_type :flag,  content_type: /image/
	validates_attachment_size :flag, less_than: 2.megabytes

	def to_param
		identifier
	end

	def set_identifier
		self.identifier = self.name.parameterize
	end
end
