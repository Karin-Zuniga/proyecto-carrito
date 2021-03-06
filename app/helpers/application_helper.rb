module ApplicationHelper

    def validar_carro
        if session[:carro_id]
            carro_id = session[:carro_id]
            @carro = Carro.find(carro_id)
        else
            @carro = Carro.create(total: 0)
            session[:carro_id] = @carro.id
        end
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path
    end


    def validar_sesion_cliente
        if session[:usuario_id]
            # tengo que ir a buscar al admin o al cliente
            @usuario_actual = Administrador.find(session[:usuario_id])
        else
            @usuario_actual = nil
        end
    rescue ActiveRecord::RecordNotFound
        session[:usuario_id] = nil
        redirect_to root_path

    end

    def validar_sesion_admin
        if session[:usuario_id]
            #cuando el usuario a iniciado
            @usuario_actual = Administrador.find(session[:usuario_id])
        else
            @usuario_actual = nil
            redirect_to root_path
        end

    rescue ActiveRecord::RecordNotFound
        redirect_to root_path

    end

    def usuario_ha_iniciado_sesion?
        if @usuario_actual
            return true
        else
            return false
        end
        
    end

    def sesion_admin
        if usuario_signed_in?

            if current_usuario.tipo_usuario_id == 2
                redirect_to root_path
                
            end
        else 
            :authenticate_usuario!
        end
    end
    
end
