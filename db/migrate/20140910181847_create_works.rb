class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works, force: true do |t|
      t.string :label
      t.integer :user_id
      t.string :period

      t.timestamps
    end
  end
end
