class Api::UsersController < ApplicationController
  skip_before_action :authenticate_request

  def index; end
end
