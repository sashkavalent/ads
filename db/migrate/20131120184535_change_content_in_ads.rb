class ChangeContentInAds < ActiveRecord::Migration
  def change
    change_column :ads, :content, :text
  end
end
