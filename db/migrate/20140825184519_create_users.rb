class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, force: true do |t|
      t.string :label
      t.integer :team_id

      t.timestamps
    end
  end
end
