class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    auth = request.env["omniauth.auth"]
    user = User.where(provider: auth.provider, uid: auth.uid)
            .first_or_initialize(email: auth.info.email, password: Devise.friendly_token[0,20], name: auth.info.name)

    sign_in(:user, user)

    redirect_to after_sign_in_path_for(user)

  end

  def github
    auth = request.env["omniauth.auth"]
    user = User.where(provider: auth.provider, uid: auth.uid)
            .first_or_initialize(email: auth.info.nickname, password: Devise.friendly_token[0,20], name: auth.info.nickname)

    sign_in(:user, user)

    redirect_to after_sign_in_path_for(user)
  end

end
