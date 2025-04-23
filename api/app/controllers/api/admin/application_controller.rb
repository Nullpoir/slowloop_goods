module Api
  module Admin
    class ApplicationController < ApplicationController
      before_action :authenticate_api_user!
    end
  end
end
