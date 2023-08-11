class ApplicationController < ActionController::API
  
  def current_user
    authenticate_api_v1_user!
  end

  def authenticate_user!
    authenticate_api_v1_user!
  end
  
  def authenticate_api_v1_user!
    token_payload = decoded_token
    if token_payload.nil? || token_payload['exp'].to_i < Time.now.to_i
      render json: { error: 'Token expired or invalid. Please sign in again.' }, status: :unauthorized
    else
      @current_user = User.find(token_payload['user_id'])
    end
  end

  private

  def decoded_token
    token = request.headers['Authorization']&.split&.last
    return nil unless token

    begin
      decoded_payload, _ = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      decoded_payload
    rescue JWT::DecodeError, JWT::ExpiredSignature
      nil
    end
  end

end
