module ApplicationHelper

	def select_field(builder, object, attribute, collection, value, name,
			 prompt= '', klass= '')
		builder.select attribute,
			options_from_collection_for_select(collection, value, name,
			 object.try(attribute)),
        	prompt: prompt, :class => klass

	end
end
