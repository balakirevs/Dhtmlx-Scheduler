class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :label
      t.boolean :open

      t.timestamps
    end
  end
end
