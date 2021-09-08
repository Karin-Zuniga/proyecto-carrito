class CarrosController < ApplicationController
    before_action :validar_carro
    
    # POST
    def agregar_productos
        #@carro.productos << Producto.find(params[:producto_id])
        #actualizar_total
        producto_para_agregar = Producto.find(params[:producto_id])
        contenido_carrito = @carro.carros_contenidos.find_by(producto: producto_para_agregar)
        
        if contenido_carrito
            contenido_carrito.cantidad +=1
        else
            contenido_carrito = CarrosContenido.new(
                carro: @carro,
                producto: producto_para_agregar,
                cantidad: 1)
    
        end
        contenido_carrito.save
        redirect_to root_path
    end

    def aumentar_cantidad_productos
        producto_para_agregar = Producto.find(params[:producto_id])
        contenido_carrito = @carro.carros_contenidos.find_by(producto: producto_para_agregar)
        contenido_carrito.cantidad +=1
        contenido_carrito.save
        redirect_to carrito_path
    end

    def eliminar_productos
        # tabla carros-contenido
        #quitar producto
        @carro.carros_contenidos.find_by(producto_id: params[:id_producto]).destroy
        redirect_to carrito_path
        
    end

    #DELETE
    def disminuir_cantidad_productos
        contenido = @carro.carros_contenidos.find_by(producto_id: params[:producto_id])
        if contenido.cantidad - 1 <= 0
            contenido.destroy

        else contenido.cantidad -= 2
            contenido.save
        end 
        redirect_to carrito_path
    end
    private 
    # def actualizar_total
    #     @carro.total = @carro.productos.map(&:precio).sum
    #     @carro.save
    # end
end