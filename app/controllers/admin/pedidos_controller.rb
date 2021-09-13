class Admin::PedidosController < Admin::AdminController
    
    # GET
    def listar
        @pedidos = Pedido.select(:codigo, :total, :created_at).order(created_at: :desc)
    end

    # GET
    def mostrar
    end

    # GET
    def crear
    end

    # GET
    def editar
    end

    # POST
    def guardar
    end

    # PUT/PATCH
    def actualizar
    end

    # DELETE
    def eliminar
    end

    private 
    def params_pedidos
    end

end