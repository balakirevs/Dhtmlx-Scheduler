class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams, force: true do |t|
      t.string :label
      t.boolean :open

      t.timestamps
    end
  end
end
