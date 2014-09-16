class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events, id: :uuid, force: true do |t|
      t.text :text
      t.datetime :start_date
      t.datetime :end_date
      t.uuid :work_id
      
      t.timestamps
    end
  end
end
