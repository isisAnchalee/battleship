class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all

    binding.pry
    user = User.from_omniauth(request.env["omniauth.auth"])
    user.email = request.env["omniauth.auth"]['info']['nickname']

    if user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :twitter, :all
end