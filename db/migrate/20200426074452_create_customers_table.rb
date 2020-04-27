class CreateCustomersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.boolean :is_active, default: true

      # updated_at, created_at
      t.timestamps
    end
  end
end