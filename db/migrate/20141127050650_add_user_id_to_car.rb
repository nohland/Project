class AddUserIdToCar < ActiveRecord::Migration
  def change
      change_table :cars do |t|
      t.integer :user_id
    end
  end
end
