class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include DeviseHackFakeSession # deviseの対応待ち
  include ApiRenderable
  include ApiPaginate

  private

  def limit
    @limit = params[:limit].nil? ? 50 : params[:limit]
  end

  def offset
    @offset = params[:offset].nil? ? 0 : params[:offset]
  end

  def order_by
    @order_by = params[:order_by].nil? ? 'id' : params[:order_by]
  end

  def direction
    @direction = params[:direction].nil? ? 'asc' : params[:direction]
  end

  def render_success_destroy
    render json: { success: true }, status: :ok
  end
end
