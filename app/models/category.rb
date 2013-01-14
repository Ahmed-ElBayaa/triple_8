class Category < ActiveRecord::Base
	
	has_many :sub_categories, class_name: 'Category', foreign_key: 'parent_id'

	accepts_nested_attributes_for :sub_categories
	
	has_many :classifieds_sub, class_name:'Classified',
		foreign_key: 'sub_category_id', dependent: :nullify
	has_many :classifieds_main, class_name:'Classified',
		foreign_key: 'main_category_id', dependent: :nullify

	before_save :set_identifier

	validates :name, presence: true, :uniqueness => {scope: :parent_id}
	validate :parent_must_be_main_category

	def self.roots
		Category.where(parent_id: nil)
	end

	def to_param
		identifier
	end

	def set_identifier
		self.identifier = self.name.parameterize+
			"#{self.id}#{Random.new.rand(100..999)}"
	end

	def main_category?
		self.parent_id == nil
	end

	def include_sub_category? sub_category
		sub_category.try(:get_parent_id) == self.id
	end

	def get_parent_id
		self.parent_id
	end

	def children
		self.sub_categories
	end

	def children_names
		names = []
		self.sub_categories.each {|child| names << child.name}
		names
	end

	def parent
		Category.find_by_id(self.parent_id)
	end

	def classifieds
		if self.main_category?
			self.classifieds_main
		else
			self.classifieds_sub
		end
	end

	def parent_must_be_main_category
		unless self.main_category? or self.parent.main_category?
			errors.add(:base, I18n.t(
				"models.category.errors.invalid_main_category"))	
		end
	end
end
