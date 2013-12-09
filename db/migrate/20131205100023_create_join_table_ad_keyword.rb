class CreateJoinTableAdKeyword < ActiveRecord::Migration
  def change
    create_table :ads_keywords, id: false do |t|
      t.integer :ad_id
      t.integer :keyword_id
    end
  end
end
