class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :nome
      t.string :especie
      t.string :raca
      t.references :cliente, null: false, foreign_key: true

      t.timestamps
    end
  end
end
