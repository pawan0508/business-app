# frozen_string_literal: true

# app/controllers/api/v1/users/registrations_controller.rb

module Api
  module V1
    module Users
      # Controller for user registrations
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        def create
          build_resource(sign_up_params)
          role = params[:role]

          resource.save
          if resource.persisted?
            assign_role_and_sign_up(resource, role)
          else
            render_errors(resource)
          end
        end

        private

        def assign_role_and_sign_up(user, role)
          user.assign_role(role)
          sign_up(resource_name, user)
          render json: { message: 'Successfully signed up.' }, status: :created
        end

        def render_errors(resource)
          render json: { error: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end

        def sign_up_params
          params.permit(:email, :password, :password_confirmation, :first_name,
                        :last_name, :primary_mobile, :secondary_mobile, :linkedin_url,
                        :experience, :bio, :achievements)
        end
      end
    end
  end
end
