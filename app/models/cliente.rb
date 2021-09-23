class Cliente < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates(:nombre, presence: true)
         validates(:direccion, presence: true)
         validates(:telefono, presence: true)
         validates(:email, presence: true)
         validates(:password, presence: true)
end
