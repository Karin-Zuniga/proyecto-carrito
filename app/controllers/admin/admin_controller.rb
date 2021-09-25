class Admin::AdminController < ApplicationController
    include ApplicationHelper

    before_action :sesion_admin

end