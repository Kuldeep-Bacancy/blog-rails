# frozen_string_literal: true

class RegistrationsController < BaseController
  skip_before_action :authenticate_request, only: [:signup]

  def signup
    user = User.new(sign_up_params)
    if user.valid?
      user.save
      render_json('Sign up successfully', { email: user.email })
    else
      render_422(user.errors.full_messages)
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password)
  end
end
