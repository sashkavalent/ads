class AddSubsectionIdToAds < ActiveRecord::Migration
  def change
    add_column :ads, :subsection_id, :integer
  end
end
