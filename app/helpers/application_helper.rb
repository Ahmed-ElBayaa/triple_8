module ApplicationHelper

	def select_field(builder, object, attribute, collection, value, name,
			 prompt= '', klass= 'select',include_blank=false)
	  if include_blank
	  	builder.select attribute,
				options_from_collection_for_select(collection, value, name,
			 		object.try(attribute)),
			 		 include_blank: prompt,	:class => klass
	  else	
			builder.select attribute,
				options_from_collection_for_select(collection, value, name,
			 		object.try(attribute)),
        		prompt: prompt, :class => klass
  	end
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

	def sub_categories main_category_id
		main_category = Category.find_by_id(main_category_id)
		main_category.try(:children) || []
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
	  
	  link_to title, params.merge(sort: column, direction: dir), :class => css_class
	end
	
end
