module ClassifiedsHelper

	def main_categories
		Category.roots
	end

	def locations
		Country.all
	end
	
end
