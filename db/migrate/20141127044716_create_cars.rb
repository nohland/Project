class CreateCars < ActiveRecord::Migration
  def change
      create_table :cars do |t|
      		   t.string :car_description
end
  end
end
