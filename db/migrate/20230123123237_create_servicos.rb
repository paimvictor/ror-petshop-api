class CreateServicos < ActiveRecord::Migration[7.0]
  def change
    create_table :servicos do |t|
      t.string :titulo
      t.float :preco
      t.datetime :data_agendamento
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
