class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :title
      t.float :price
      t.datetime :scheduled_date
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
