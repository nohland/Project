class CreateUsers < ActiveRecord::Migration
  def change
      create_table :users do |t|
      		   t.string :description
		   t.string :due
end
  end
end
