class Api::V1::GoodsController < ApplicationController
  before_action :good, only: %i(show)

  def index 
    render json: resources, each_serializer: GoodSerializer
  end

  def show
    render json: @good, serializer: GoodSerializer
  end

  private

  def resources_scope
    Good.all
  end

  def good
    @good = Good.find(params[:id])
  end
end
