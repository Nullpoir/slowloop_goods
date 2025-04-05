class Api::Admin::ApplicationController < ApplicationController
  before_action :authenticate_api_user!
end
