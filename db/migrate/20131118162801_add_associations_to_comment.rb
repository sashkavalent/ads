class AddAssociationsToComment < ActiveRecord::Migration
  def change
    add_column :comments, :ad_id, :integer
    add_column :comments, :user_id, :integer
  end
end
