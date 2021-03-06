class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    products_path
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :image, address_attributes: [:address1, :address2, :city, :state, :country, :postal_code]])
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :phone, :image, :password, :password_confirmation, :current_password, address_attributes: [:id, :address1, :address2, :city, :state, :country, :postal_code])}
    end
end
