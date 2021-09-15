class Admin::PedidosController < Admin::AdminController
    
    include Admin::PedidosHelper

    before_action :asignar_pedido, only: [:mostrar, :editar, :actualizar, :aumentar_cantidad_productos]

    # GET
    def listar
        
        @pedidos = Pedido.select(:id, :codigo, :total, :created_at).order(created_at: :desc)
    end

    # GET
    def mostrar
        #TODO mostrar un pedido con todos los productos
    end
    
    def agregar_producto
        @todos_los_productos = Producto.select(:id, :nombre, :precio, :estados_producto_id).order(nombre: :asc).where("estados_producto_id = 1 and cantidad > 0")
    end
    # GET
    def crear
        #TODO mostra el formulario para crear un pedido con productos
    end

    # GET
    def editar
        #TODO editar la info de un pedido EXCEPTO el código
        # @datos_pedido = @pedido.datos_envio
        @datos_pedido = PedidosFormulario.new
        @datos_pedido.id            = @pedido.id
        @datos_pedido.nombre        = @pedido.datos_envio.nombre
        @datos_pedido.correo        = @pedido.datos_envio.correo
        @datos_pedido.telefono      = @pedido.datos_envio.telefono
        @datos_pedido.direccion     = @pedido.datos_envio.direccion
        @datos_pedido.destino_id    = @pedido.destino.id
        
        @datos_pedido.estado_id = @pedido.estados_pedido.id
        @estados = EstadosPedido.select(:id, :estado)

        @destinos   = Destino.select(:id, :nombre).order(nombre: :asc)
    
        @productos = @pedido.detalles_pedidos
    end

    # POST
    def guardar
    end

     # POST
     def guardar_producto
        detalle_pedido = @pedido.detalles_pedidos.find_by(producto_id: params[:id_producto])
        if detalle_pedido
            detalle_pedido.cantidad += 1
        else
            detalle_pedido = DetallesPedido.new(
                pedido: @pedido,
                producto_id: params[:id_producto],
                cantidad: 1
            )
        end
        detalle_pedido.save
        
        redirect_to action: :editar
    end

    # PUT/PATCH
    def actualizar
        @datos_pedido = PedidosFormulario.new(params_pedidos)
        if @datos_pedido.valid?
            
            @pedido.datos_envio.nombre = @datos_pedido.nombre
            @pedido.datos_envio.correo = @datos_pedido.correo
            @pedido.datos_envio.telefono = @datos_pedido.telefono
            @pedido.datos_envio.direccion = @datos_pedido.direccion
            
            @pedido.destino = Destino.find(@datos_pedido.destino_id)
            @pedido.estados_pedido = EstadosPedido.find(@datos_pedido.estado_id)        # línea nueva 🌟

            if @pedido.datos_envio.save and @pedido.save
                redirect_to action: :mostrar
            else                
                @destinos = Destino.select(:id, :nombre).order(nombre: :asc)
                @estados    = EstadosPedido.select(:id, :estado).order(estado: :asc)    # línea nueva 🌟
                render :editar
            end
        else
            @destinos = Destino.select(:id, :nombre).order(nombre: :asc)
            @estados    = EstadosPedido.select(:id, :estado).order(estado: :asc)        # línea nueva 🌟
            render :editar
        end
    end

    # DELETE
    def eliminar
        #TODO analizar si vamos a eliminar el pedido o vamos a cambiar de estado
    end

    def aumentar_cantidad_productos
        detalles_pedido = @pedido.detalles_pedidos.find(params[:id_producto])
        detalles_pedido = pedido.cantidad +=1
        detalles_pedido.save

        redirect_to :editar


    end

    # DELETE pedidos/:id/productos/:id_producto
    def disminuir_cantidad_producto
        detalle_pedido = @pedido.detalles_pedidos.find_by(producto_id: params[:id_producto])
        if detalle_pedido.cantidad - 1 <= 0
            detalle_pedido.destroy
        else
            detalle_pedido.cantidad -= 1
            detalle_pedido.save
        end

        redirect_to action: :editar
        # respond_to do |format|
        #     format.json { render json: {id: detalle_pedido.producto.id, cantidad: detalle_pedido.cantidad} }
        # end
    end

    # DELETE pedidos/:id/productos/:id_producto/eliminar
    def eliminar_producto
        detalle_pedido = @pedido.detalles_pedidos.find_by(producto_id: params[:id_producto])
        detalle_pedido.destroy

        redirect_to action: :editar
    end

    private 
    def params_pedidos
        params.require(:admin_pedidos_helper_pedidos_formulario).permit(:nombre, :correo, :telefono, :direccion, :destino_id)
    end

    def asignar_pedido
        
        @pedido = Pedido.find(params[:id])

    rescue ActiveRecord::RecordNotFound

        flash[:errors] = "Pedido #{params[:id]} no encontrado"
        redirect_to action: :listar
    end

end
