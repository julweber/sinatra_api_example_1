class CreateMoviesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.belongs_to :customer, null: false
      t.string :director
      t.string :title
      t.string :genre
      t.string :rating, default: 0


      # updated_at, created_at
      t.timestamps
    end
  end
end