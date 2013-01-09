class RegistrationsController < Devise::RegistrationsController
	# skip_before_filter :must_be_admin
	# def new
	# 	@countries = Country.select( [:id,:name])
	# 	super
	# end

	# def create
	# 	@countries = Country.select( [:id,:name])
	# 	super
	# end

end
