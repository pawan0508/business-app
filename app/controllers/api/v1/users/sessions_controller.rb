# app/controllers/api/v1/users/sessions_controller.rb

module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        def create
          user = User.find_by(email: params[:email])

          if user && user.valid_password?(params[:password])
            token = generate_jwt_token(user)
            render json: { message: 'Login Successfully', token: token }, status: :created
          else
            render json: { error: 'Invalid email or password' }, status: :unprocessable_entity
          end
        end

        private

        def generate_jwt_token(user)
          payload = { user_id: user.id, exp: 2.hours.from_now.to_i }
          JWT.encode(payload, Rails.application.secrets.secret_key_base)
        end
      end
    end
  end
end
