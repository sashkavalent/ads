class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :wallet_id
      t.integer :amount

      t.timestamps
    end
  end
end
