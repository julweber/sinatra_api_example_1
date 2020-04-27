class CreateRecordsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.belongs_to :customer, null: false
      t.string :artist
      t.string :title
      t.string :format
      t.string :genre


      # updated_at, created_at
      t.timestamps
    end
  end
end