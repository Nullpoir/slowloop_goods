class Api::Admin::GoodsController < Api::Admin::ApplicationController
  before_action :good, only: %i(show update destroy)
  before_action :init_good, only: %i(create)

  def index
    render json: resources, each_serializer: GoodSerializer
  end

  def show
    render_json
  end

  def create
    @good.save!
    render_json
  end

  def update
    @good.update!(good_params)
    render_json
  end
  
  def destroy
    @good.destroy!
    render_success_destroy
  end

  private

  def render_json
    render json: @good, serializer: GoodSerializer
  end

  def resources_scope
    Good.all
  end

  def init_good
    @good = Good.new(good_params)
  end

  def good
    @good = Good.find(params[:id])
  end

  def good_params
    params.require(:good)
          .permit(
            :name,
            :description,
            :isbn,
            :jan,
            :shopping_url,
            :released_at,
            :production_ended_at
          )
  end
end
