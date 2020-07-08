class ApplicationController < ActionController::API

  def authenticate_api_key
    if request.headers['x-api-key'] != ENV["API_KEY"]
      render status: :forbidden
    end
  end

end
