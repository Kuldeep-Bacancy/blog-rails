# frozen_string_literal: true

class SessionsController < BaseController
  skip_before_action :authenticate_request, only: [:login]

  def login
    user = User.find_by_email(signin_params[:email])
    if user&.authenticate(signin_params[:password])
      render_json('Sign in successfully', { email: user.email, token: jwt_encode(user_id: user.id) })
    else
      render json: { status: 'Non-Authoritative Information', message: ['You entered in an incorrect email or password,please try again.'], data: [], status_code: 203, messageType: 'error' },
             status: 203
    end
  end

  def logout
    token = request.headers['Authorization']&.split(' ')&.last
    if token.present?
      BlackListToken.find_or_create_by(user_id: current_user.id, token:)
      render_json('Logout Successfully!')
    else
      render_401
    end
  end

  private

  def signin_params
    params.require(:user).permit(:email, :password)
  end
end
