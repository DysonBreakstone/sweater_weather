require "securerandom"

class Api::V0::UsersController < ApplicationController
  def create
    body = JSON.parse(request.body.read, symbolize_names: true)
    body[:api_key] = SecureRandom.hex(24)
    user = User.new(body)
    if user.save
      render json: UsersSerializer.new(user), status: 201
    else
      render json: user.errors.full_messages, status: 422
    end
  end
end