class Classified < ActiveRecord::Base

	has_many :attachments, dependent: :destroy
	
	belongs_to :main_category, class_name: 'Category'
	belongs_to :sub_category, class_name: 'Category'
	
	belongs_to :user

	accepts_nested_attributes_for :attachments, allow_destroy: true,
						 reject_if: lambda { |a| a.nil? }

	attr_accessible :attachments_attributes, :kind, :title, :description,
				:price, :main_category_id, :sub_category_id
	
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
