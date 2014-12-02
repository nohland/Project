class AddIdToCar < ActiveRecord::Migration
  def change
       change_table :calcs do |t|
       		    t.integer :car_id
    end
  end
end
