class ApplicationController < ActionController::Base
    include ApplicationHelper

    before_action :validar_sesion_admin
    
end
