class ClienteMailer < ApplicationMailer

    def enviar_hola_mundo
        mail(
            to: Rails.application.credentials.correo[:correo],
           # to: 'rrodriguez@edutecno.com'
            suject: 'Saludos'
        )
    
    end

    def enviar_correo_pedido
        @datos_envio_correo = params[:datos_envio_correo]
        @pedido_correo      = params[:pedido_correo]
        
        mail(
            to: @datos_envio_correo.correo,
            subject: "Confirmación pedido"
        )
    end
end
