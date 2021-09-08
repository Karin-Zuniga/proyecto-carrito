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
        redirect to root_path
    end
end
