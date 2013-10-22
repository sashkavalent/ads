class AddAdTypeIdToAds < ActiveRecord::Migration
  def change
    add_column :ads, :ad_type_id, :integer
  end
end
