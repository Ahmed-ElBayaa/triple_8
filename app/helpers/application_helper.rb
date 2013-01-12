module ApplicationHelper

	def select_field(builder, object, attribute, collection, value, name,
			 prompt= '', klass= '')
		builder.select attribute,
			options_from_collection_for_select(collection, value, name,
			 object.try(attribute)),
        	prompt: prompt, :class => klass

	end

	def locations
		Country.all
	end

	def countries
		Country.select( [:id,:name])
	end

	def currencies
		Currency.select( [:id,:unit])
	end

	def main_categories
		Category.roots
	end

	def main_categories_names
		names = []
		Category.roots.select([:name]).each {|c| names << c.name}
		names
	end

	def sub_categories_names main_category_name
		main_category = Category.find_by_name(main_category_name)
		names = main_category.try(:children_names) || []
	end
	
end
