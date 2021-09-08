class OtroCambio < ActiveRecord::Migration[6.1]
  def change
    remove_column :pedidos, :estados_pedido_id, :integer
    add_column :pedidos, :estados_pedido_id, :integer, references: :estados_pedidos
  end
end
