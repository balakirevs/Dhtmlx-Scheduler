class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid, force: true do |t|
      t.string :label
      t.uuid :team_id    

      t.timestamps
    end
  end
end
