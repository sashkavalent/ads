class AddPlaceIdToAds < ActiveRecord::Migration
  def change
    add_column :ads, :place_id, :integer
  end
end
