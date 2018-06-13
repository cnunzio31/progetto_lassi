# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]


  def create
    # Your custom code here. Make sure you copy devise's functionality
    #Rails.logger.debug("Salveeee #{sign_up_params}")
    #current_user.email.split("@")[1].to_s.casecmp?("test.com")
    if sign_up_params["email"].split("@")[1] == "test.com"
      #set_flash_message! :notice, :"you can't use this test.com"
      redirect_to new_user_registration_path, :notice => "You can't use @test.com"
      #respond_with resource, location: after_sign_up_path_for(resource)
      return
    end
    if sign_up_params["roles_mask"] != "1" || sign_up_params["roles_mask"] != "2"
      redirect_to new_user_registration_path, :notice => "You can only be Master or Player"
      #set_flash_message! :notice, :"You can only be Master o Player"
      return
    end

    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  # Notice the name of the method
  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
    #params.require(:user).permit(:display_name, :email, :password, :password_confirmation)
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
