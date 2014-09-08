class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :text
      t.datetime :start_date
      t.datetime :end_date
      t.integer :user_id

      t.timestamps
    end
  end
end
