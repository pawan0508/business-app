# frozen_string_literal: true

# app/controllers/api/v1/users_controller.rb
module Api
  module V1
    module Users
      # Crud operation for registered users
      class UsersController < ApplicationController
        before_action :authenticate_user!


        def index
          @users = User.all
          render json: @users
        end

        def edit
          @user = User.find(params[:id])
          render json: @user
        end

        def show
          @user = User.find_by(id: params[:id])
          render json: @user
        end

        def update
          @user = User.find_by(id: params[:id])

          @user.update(user_params)
          if params[:password].blank?
            save_and_render_user
          elsif @user.save
            render json: @user
          else
            render json: { error: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :primary_mobile,
                        :secondary_mobile, :linkedin_url, :experience, :bio, :achievements)
        end

        def save_and_render_user
          if @user.save(validate: false)
            render json: @user
          else
            render json: { error: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
