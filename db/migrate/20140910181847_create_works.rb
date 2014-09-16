class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works, id: :uuid, force: true do |t|
      t.string :label
      t.uuid :user_id
      t.string :period

      t.timestamps
    end
  end
end
