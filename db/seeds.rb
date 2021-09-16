# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#tiposPago: destroy.all

EstadosProducto.create([
    {estado: 'activo'},
    {estado: 'inactivo'}
])

TiposPago.create([
    {pago: 'efectivo'},
    {pago: 'tarjeta'}
])



EstadosPedido.create([
    {estado: 'solicitado'},
    {estado: 'enviado'},
    {estado: 'entregado'}

])



Region.create([
    {nombre: 'Región de Arica y Parinacota'},
    {nombre: 'Región de Tarapacá'},
    {nombre: 'Región de Antofagasta'},
    {nombre: 'Región de Atacama'},
    {nombre: 'Región de Coquimbo'},
    {nombre: 'Región de Valparaíso'},
    {nombre: 'Región Metropolitana de Santiago'},
    {nombre: 'Región del Libertador General Bernardo OHiggins'},
    {nombre: 'Región del Maule'},
    {nombre: 'Región de Ñuble'},
    {nombre: 'Región del Biobío'},
    {nombre: 'Región de La Araucanía'},
    {nombre: 'Región de Los Ríos'},
    {nombre: 'Región de Los Lagos'},
    {nombre: 'Región Aysén del General Carlos Ibáñez del Campo'},
    {nombre: 'Región de Magallanes y de la Antártica Chilena'},
    {nombre: 'Sin región'}
])

Destino.create{
    [ nombre: 'Sin destino', region: Region.find_by(nombre: 'Sin región')]
}