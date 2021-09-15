# frozen_string_literal: true

module Admin
    module PedidosHelper
      # Modelo para construir la vista del pedido
      class PedidosFormulario
        include ActiveModel::Model
  
        attr_accessor(:id, :nombre, :correo, :direccion, :telefono, :destino_id, :estado_id)
  
        validates(:nombre, presence: true)
        validates(:direccion, presence: true)
        validates(:correo, presence: true)
        validates(:telefono, presence: true)
        validates(:destino_id, presence: true)
  
        def persisted?
          id != nil
        end
      end
    end
  end
  