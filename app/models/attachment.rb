class Attachment < ActiveRecord::Base

	belongs_to :classified
	# attr_accessible :file
	has_attached_file :file, :styles => { :medium => "300x300>", :thumb => "100x100>" }	

end
