class BaseController < ApplicationController
  include JsonWebToken
  include ApplicationErrors

  before_action :authenticate_request

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    begin
      if token.present?
        return render_401 if BlackListToken.find_by(token:)

        decoded = jwt_decode(token)
        @current_user = User.find_by(id: decoded[:user_id])
      else
        render_401
      end
    rescue (JWT::ExpiredSignature || JWT::DecodeError) => e
      render_401
    end
  end
end
