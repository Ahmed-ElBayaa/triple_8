class SessionsController < Devise::SessionsController
	skip_before_filter :must_be_admin  
end
