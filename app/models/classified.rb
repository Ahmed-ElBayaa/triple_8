class Classified < ActiveRecord::Base

	KINDS = ["Wanted", "For Sale"]
	MAX_ATTACHMENTS_NO = 3

	has_many :attachments, dependent: :destroy
	
	belongs_to :main_category, class_name: 'Category'
	belongs_to :sub_category, class_name: 'Category'
	
	belongs_to :user

	accepts_nested_attributes_for :attachments, allow_destroy: true

	attr_accessible :attachments_attributes, :kind, :title, :description,
				:price, :main_category_id, :sub_category_id
	
	before_save :set_identifier

	validates :title, :kind, :user_id, :main_category_id,
				:sub_category_id, :price, presence: true
	validates :title, uniqueness: :true
	validates :kind, inclusion: KINDS
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validate :categories_validations
	validate :attachments_validations

	def to_param
		identifier
	end

	def set_identifier
		self.identifier = self.title.parameterize
	end

	def attachments_validations
		self.attachments.each do |photo|			
			unless photo.file_content_type.match /image/
				errors.add(:base,"you may attach photos only")	
			end
			if photo.file_file_size > 2.megabytes
				errors.add(:base,"At most 2mb images allowed")	
			end
		end
	end

	def categories_validations
		if self.main_category and self.main_category.main_category?
			unless self.main_category.include_sub_category? self.sub_category
				errors.add(:base,"invalid sub category")	
			end
		else
			errors.add(:base,"invalid main category")	
		end
	end

	def complete_attachments_number
    i = MAX_ATTACHMENTS_NO - self.attachments.count
    i.times {self.attachments.build}
  end

end
