class ApplicationController < ActionController::API
  
  def current_user
    current_api_v1_user
  end

end
