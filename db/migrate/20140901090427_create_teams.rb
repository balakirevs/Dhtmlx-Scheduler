class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams, id: :uuid, force: true do |t|
      t.string :label
      t.boolean :open

      t.timestamps
    end
  end
end
