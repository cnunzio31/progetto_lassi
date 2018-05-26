class ApplicationController < ActionController::Base
  rescue_from Cancan:AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
end
