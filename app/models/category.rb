class Category < ActiveRecord::Base
	
	has_ancestry

	has_many :classifieds_sub, class_name:'Classified', foreign_key: 'sub_category_id'
	has_many :classifieds_main, class_name:'Classified', foreign_key: 'main_category_id'

	before_save :set_identifier

	validates :name, uniqueness: :true

	def to_param
		identifier
	end

	def set_identifier
		self.identifier = self.name.parameterize
	end

	def main_category?
		self.parent == nil
	end

	def classifieds
		if self.main_category?
			classifieds = self.classifieds_main
		else
			classifieds = self.classifieds_sub
		end
	end
end
