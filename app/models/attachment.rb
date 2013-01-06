class Attachment < ActiveRecord::Base

	belongs_to :classified

	has_attached_file :file, styles: { medium: "300x300>", 
		thumb: "100x100>" }	

	#validates_attachment_content_type :file,  content_type: /image/
	validates_attachment_size :file, less_than: 2.megabytes

end
