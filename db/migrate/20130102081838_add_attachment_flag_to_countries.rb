class AddAttachmentFlagToCountries < ActiveRecord::Migration
  def self.up
    change_table :countries do |t|
      t.attachment :flag
    end
  end

  def self.down
    drop_attached_file :countries, :flag
  end
end
