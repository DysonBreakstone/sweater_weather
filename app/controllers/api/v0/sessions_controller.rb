class Api::V0::SessionsController < ApplicationController
  def create
    body = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(email: body[:email])
    if user
      if user.authenticate(body[:password])
        session[:user_id] = user.id
        render json: UsersSerializer.new(user), status: 200
      else
        render json: { errors: "User does not exist or email and password don't match." }, status: 422
      end
    else
      render json: { errors: "User does not exist or email and password don't match." }, status: 404
    end
  end
end