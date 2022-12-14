class Api::Admin::GoodsController < AdminController
  before_action :good, only: %i(show update destroy)
  before_action :init_good, only: %i(create)

  def index
    render json: goods, each_serializer: GoodSerializer
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

  def goods
    @goods ||= Good.ransack(params[:q])
                   .result 
                   .order(order_by => direction)
                   .limit(limit).offset(offset)
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
