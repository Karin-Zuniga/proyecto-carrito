class CreatePedidos < ActiveRecord::Migration[6.1]
  def change
    create_table :pedidos do |t|
      t.string :codigo
      t.integer :total
      t.references :destino, null: false, foreign_key: true
      t.references :datos_envio, null: false, foreign_key: true
      t.references :estados_pedidos, null: false, foreign_key: true

      t.timestamps
    end
  end
end
