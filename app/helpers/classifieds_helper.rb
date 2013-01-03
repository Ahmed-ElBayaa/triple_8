module ClassifiedsHelper

	def get_main_categories
		Category.roots
	end

	def get_sub_categories main_category=nil
		if main_category
			main_category.children
		else
			Category.all
		end
	end

end
