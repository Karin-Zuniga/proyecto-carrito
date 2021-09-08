class MismoCambio < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :pedidos, :estados_pedidos

  end
end
