module Api
  module v1
    class Api::ApiController < ApplicationController
      before_action :authenticate_user!
      respond_to :json
    end
  end
end