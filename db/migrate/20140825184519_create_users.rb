class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :label
      t.integer :team_id

      t.timestamps
    end
  end
end
