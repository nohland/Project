class CreateCalculations < ActiveRecord::Migration
  def change
       create_table :calcs do |t|
                   t.integer :miles
                   t.float :gallons
                   t.float :ppg
                   t.string :date
		   t.float :mileage
		   t.float :t_price
		   
end
  end
end
