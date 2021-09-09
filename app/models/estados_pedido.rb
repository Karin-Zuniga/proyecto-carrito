class EstadosPedido < ApplicationRecord
    has_many :pedidos

    validates(:estado, uniqueness: true)
    validates(:estado, presence: true)
end
