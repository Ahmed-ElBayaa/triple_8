module CategoriesHelper
	def get_main_categories
		Category.roots
	end

	def get_sub_categories
		children = Category.roots.first.children
	end
end
