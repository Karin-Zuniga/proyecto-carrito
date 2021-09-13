class PaginasController < ApplicationController

    before_action :validar_carro
    
    def inicio
        @todos_los_productos = Producto.select(:id, :nombre, :precio, :estados_producto_id).order(nombre: :asc).where("estados_producto_id = 1 and cantidad > 0")
    end

    def carro
        
    end

    def enviar_saludo
        ClienteMailer.with(saludo: 'hola').enviar_hola_mundo.deliver_later


    end
end