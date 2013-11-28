class AddAdIdToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :ad_id, :integer
  end
end
