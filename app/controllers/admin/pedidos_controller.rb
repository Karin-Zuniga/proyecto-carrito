class Admin::PedidosController < Admin::AdminController
    
    include Admin::PedidosHelper

    before_action :asignar_pedido, except: [:listar, :crear, :guardar]

    # GET
    def listar
        
        @pedidos = Pedido.select(:id, :codigo, :total, :created_at, :estados_pedido_id).order(created_at: :desc)
    end

    # GET
    def mostrar
        
    end
    
    def agregar_producto
        @todos_los_productos = Producto.select(:id, :nombre, :precio, :estados_producto_id).order(nombre: :asc).where("estados_producto_id = 1 and cantidad > 0")
    end
    # GET
    def crear
        #TODO mostra el formulario para crear un pedido con productos
        @pedido = Pedido.new
        @pedido.codigo = SecureRandom.hex(4).upcase
        @pedido.total = 0
        @pedido.estados_pedido = EstadosPedido.find_by(estado: 'solicitado')
        @pedido.destino = Destino.find_by(nombre: 'Sin destino')
        @pedido.datos_envio = DatosEnvio.create(
            nombre:     'ingrese nombre',
            telefono:   'ingrese telefono',
            direccion:  'ingrese direccion',
            correo:     'ingrese correo',
        )
        

        @pedido.save

        redirect_to admin_editar_pedido_path(@pedido)
        # @datos_pedido = PedidosFormulario.new
        # @estados = EstadosPedido.select(:id, :estado).order(estado: :asc)
        # @destinos = Destino.select(:id, :nombre).order(nombre: :asc)
    end

    # GET
    def editar
        
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

    def aumentar_cantidad_producto
        @detalle_pedido = @pedido.detalles_pedidos.find_by(producto_id: params[:id_producto])
        @detalle_pedido.cantidad += 1
        @detalle_pedido.save

        redirect_to admin_editar_pedido_path(@pedido)


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
        
    end

    # DELETE pedidos/:id/productos/:id_producto/eliminar
    def eliminar_producto
        detalle_pedido = @pedido.detalles_pedidos.find_by(producto_id: params[:id_producto])
        detalle_pedido.destroy

        redirect_to action: :editar
    end

    private 
    def params_pedidos
        params.require(:admin_pedidos_helper_pedidos_formulario).permit(:nombre, :correo, :telefono, :direccion, :destino_id, :estado_id)
    end

    def asignar_pedido
        
        @pedido = Pedido.find(params[:id])

    rescue ActiveRecord::RecordNotFound

        flash[:errors] = "Pedido #{params[:id]} no encontrado"
        redirect_to action: :listar
    end

end
