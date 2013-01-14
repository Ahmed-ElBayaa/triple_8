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
		Currency.select( [:id,:name])
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

	def format_price classified
		number_to_currency(classified.price,
			unit: classified.currency.name)
	end

	def sortable(model,column, title = nil)
		column = column.downcase.tr(' ', '_')
	  title ||= column.titleize
	  dir = column == sort_column(model) &&
	   sort_direction == "asc" ? "desc" : "asc"
	  dir_icon = dir == 'asc' ? 'icon-chevron-up' : 'icon-chevron-down'
	  css_class = column == sort_column(model) ? "current #{dir} #{dir_icon}" : nil
	  
	  link_to title, {sort: column, direction: dir}, :class => css_class
	end
	
end
