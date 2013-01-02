module UsersHelper
	def get_countries
		Country.select( [:id,:name])
	end
end
