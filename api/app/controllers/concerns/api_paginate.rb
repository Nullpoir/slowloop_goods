module ApiPaginate
  extend ActiveSupport::Concern

  def pagination_dict(resources)
    pagination_columns.map do |key|
      { key => resources[key] }
    end.reduce(&:merge)
  end

  def pagination_columns
    %i[order_type page per next_page prev_page]
  end

  protected

  def resources
    @resources ||= resources_scope
                   .ransack(params[:q])
                   .result
                   .page(page)
                   .per(per)
  end

  def pagination
    {
      total_count: total_count.to_i,
      page: page.to_i,
      per: per.to_i,
      next_page: ActiveModel::Type::Boolean.new.cast(next_page),
      prev_page: ActiveModel::Type::Boolean.new.cast(prev_page)
    }
  end

  def order_type
    pagination_params[:order_type].presence || 'n'
  end

  def page
    pagination_params[:page] || 1
  end

  def per
    pagination_params[:per] || 10
  end

  def next_page
    resources.total_pages > 1 && !resources.last_page?
  end

  def prev_page
    resources.total_pages > 1 && !resources.first_page?
  end

  def total_count
    resources.total_count
  end

  def pagination_params
    params.permit(
      :page,
      :per,
      :format,
      :q
    )
  end
end
