class Producto < ApplicationRecord
  # TODO: para clientes con rut \d{1,2}\.\d{3}\.\d{3}[-][0-9kK]{1}
  
  # TODO: Agregar valor por defecto al campo de estados_producto_id
  
  belongs_to :categoria
  belongs_to :estados_producto
  
  has_many_attached :imagenes

  has_many :carros_contenidos
  has_many :carros, through: :carros_contenidos

  has_many :detalles_pedidos
  has_many :pedidos, through: :detalles_pedidos

  validates(:nombre,      presence: true)
  validates(:nombre,      uniqueness: true)
  
  validates(:precio,      presence: true)
  validates(:precio,      numericality:  {greater_than_or_equal_to: 0})

  validates(:descripcion, presence: true)
  
  validates(:cantidad,    presence: true)
  validates(:cantidad,    numericality: {greater_than_or_equal_to: 0})

  validate(:max_imagenes)

  validates(:categoria_id,    presence: true)
  
  private

  def max_imagenes
    if self.imagenes.count > 4
      self.errors.add(:imagenes, "No puedes cargar mas de 4 fotos")
    end
  end
end
