class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays, force: true do |t|
      t.string :name
      t.datetime :date

      t.timestamps
    end
  end
end
