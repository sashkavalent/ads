class AddPriceToAds < ActiveRecord::Migration
  def change
    add_column :ads, :price, :integer
    add_column :ads, :currency_id, :integer
  end
end
