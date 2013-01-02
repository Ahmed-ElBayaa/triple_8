class Classified < ActiveRecord::Base

	has_many :attachments, dependent: :destroy
	has_and_belongs_to_many :categories
	belongs_to :user

	accepts_nested_attributes_for :attachments, allow_destroy: true,
						 reject_if: lambda { |a| a.nil? }

	attr_accessible :attachments_attributes, :kind, :title, :description,
				:price
	
	before_save :set_identifier

	validates :title, uniqueness: :true

	KINDS = ["Wanted", "For Sale"]

	def to_param
		identifier
	end

	def set_identifier
		self.identifier = self.title.parameterize
	end
end
