module UsersHelper
	def countries
		Country.select( [:id,:name])
	end
end
