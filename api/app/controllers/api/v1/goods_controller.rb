class Api::V1::GoodsController < ApplicationController
  before_action :good, only: %i(show)

  def index
    render json: goods, each_serializer: GoodSerializer
  end

  def show
    render json: @good, serializer: GoodSerializer
  end

  private

  def goods
    @goods ||= Good.ransack(params[:q])
                   .result 
                   .order(order_by => direction)
                   .limit(limit).offset(offset)
  end

  def good
    @good = Good.find(params[:id])
  end
end
