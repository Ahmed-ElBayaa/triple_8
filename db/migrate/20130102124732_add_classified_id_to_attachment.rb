class AddClassifiedIdToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :classified_id, :integer
  end
end
