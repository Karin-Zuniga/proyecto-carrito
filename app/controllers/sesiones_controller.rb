class SesionesController < ApplicationController
    def iniciar_sesion
        @usuario_actual = Administrador.find_by(correo: sesion_params[:correo])
        if @usuario_actual
            if @usuario_actual.authenticate(sesion_params[:password])
                #cuando las credenciales estan bien
                session[:usuario_id] = @usuario_actual.id
                redirect_to admin_pedidos_path
            else
                # cuando las credenciales estan incrrectas
                flash[:error_session] = "Correo/Contraseña invalidos"
                redirect_to root_path

            end
        else
            #cuando no existe el usuario en la BD
            flash[:error_sesion] = "Usuario no registrado"
            redirect_to root_path

        end
    end

    def cerrar_sesion
        session[:usuario_id] = nil
        redirect_to root_path
    end

    private

    def sesion_params
        params.permit(:correo, :password)
        
    end

end