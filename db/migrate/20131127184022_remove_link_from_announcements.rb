class RemoveLinkFromAnnouncements < ActiveRecord::Migration
  def up
    remove_column :announcements, :link
  end

  def down
    add_column :announcements, :link, :string
  end
end
