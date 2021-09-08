Rails.application.routes.draw do

  # paginas

  root 'paginas#inicio'
  get   'enviar', to: 'paginas#enviar_saludo'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #productos

  get   '/carrito'          ,  to: 'paginas#carro'

  
  post 'carros/:producto_id'                      , to: 'carros#agregar_productos'            , as: 'agregar_producto'
  put 'carros/:producto_id/cantidad_producto'     , to: 'carros#aumentar_cantidad_productos'  , as: 'aumentar_producto'
  delete 'carros/:producto_id'                    , to: 'carros#eliminar_productos'           , as: 'eliminar_producto'
  delete 'carros/:producto_id/cantidad_producto'  , to: 'carros#disminuir_cantidad_productos' , as: 'disminuir_producto'
  
  
  get 'categorias'            , to: 'categorias#listar'     , as: 'categorias'
  get 'categorias/crear'      , to: 'categorias#crear'      , as: 'nueva_categoria'
  get 'categorias/:id/editar' , to: 'categorias#editar'     , as: 'editar_categoria'
  get 'categorias/:id'        , to: 'categorias#mostrar'    , as: 'categoria'

  post    'categorias'        , to: 'categorias#guardar'
  put     'categorias/:id'    , to: 'categorias#actualizar'
  patch   'categorias/:id'    , to: 'categorias#actualizar'
  delete  'categorias/:id'    , to: 'categorias#eliminar'


  #productos
  get 'productos'            , to: 'productos#listar'   , as: 'productos'
  get 'productos/crear'      , to: 'productos#crear'    , as: 'nuevo_producto'
  get 'productos/:id'        , to: 'productos#mostrar'  , as: 'producto'
  get 'productos/:id/editar' , to: 'productos#editar'   , as: 'editar_producto'

  post    'productos'        , to: 'productos#guardar'   
  put     'productos/:id'    , to: 'productos#actualizar' 
  patch   'productos/:id'    , to: 'productos#actualizar'
  delete  'productos/:id'    , to: 'productos#eliminar'

  delete  'productos/:id/imagenes/:id_imagen',  to: 'productos#eliminar_foto',  as: 'eliminar_foto' 

  #destinos
  get 'destinos',             to: 'destinos#listar',  as: 'destinos'
  get 'destinos/crear',       to: 'destinos#crear',   as: 'nuevo_destino'
  get 'destinos/:id',         to: 'destinos#mostrar', as: 'destino'
  get 'destinos/:id/editar',  to: 'destinos#editar',  as: 'editar_destino'

  post    'destinos',     to: 'destinos#guardar'
  put     'destinos/:id', to: 'destinos#actualizar'
  patch   'destinos/:id', to: 'destinos#actualizar'
  delete  'destinos/:id', to: 'destinos#eliminar'

  #pedidos
  get   'pedidos/crear',  to: 'pedidos#crear',  as: 'nuevo_pedido'
  get   'pedidos',        to: 'pedidos#pagar',    as: 'pagar'
  
  post  'pedidos',        to: 'pedidos#guardar',  as: 'crear_pedido_cliente'
end