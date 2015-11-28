module Api
  module V1
    class ApiController < ApplicationController
      before_action :authenticate_user!
      respond_to :json
    end
  end
end