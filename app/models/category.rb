class Category < ActiveRecord::Base
	
	has_ancestry
	
	has_many :classifieds_sub, class_name:'Classified',
		foreign_key: 'sub_category_id'
	has_many :classifieds_main, class_name:'Classified',
		foreign_key: 'main_category_id'

	before_save :set_identifier

	validates :name, uniqueness: :true, presence: true
	validate :parent_must_be_main_category

	def to_param
		identifier
	end

	def set_identifier
		self.identifier = self.name.parameterize
	end

	def main_category?
		self.is_root?
	end

	def include_sub_category? sub_category
		sub_category ||= Category.new
		self.child_ids.include? sub_category.id
	end

	def classifieds
		if self.main_category?s
			self.classifieds_main
		else
			self.classifieds_sub
		end
	end

	def parent_must_be_main_category
		unless self.is_root? or self.parent.is_root?
			errors.add(:base, I18n.t(
				"models.category.errors.invalid_main_category"))	
		end
	end
end
