# app/controllers/api/v1/users_controller.rb
module Api
  module V1
    module Users
      class UsersController < ApplicationController
        load_and_authorize_resource

        def index
          @users = User.all
          render json: @users
        end
      end
    end
  end
end

