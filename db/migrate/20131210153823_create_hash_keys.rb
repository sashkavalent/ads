class CreateHashKeys < ActiveRecord::Migration
  def change
    create_table :hash_keys do |t|
      t.string :value

      t.timestamps
    end
  end
end
