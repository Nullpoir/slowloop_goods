module ApiRenderable
  extend ActiveSupport::Concern

  included do
    respond_to :json
    self.responder = ::ApiResponder

    before_action :force_json_format
    before_action :force_params_to_snakecase

    rescue_from ActiveRecord::RecordNotFound do |_exception|
      render error: :record_not_found, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      render error: :record_invalid, model: exception.record, status: :unprocessable_entity
    end
  end

  ActionController::Renderers.add :error do |obj, options|
    render_error_response obj, options
  end

  protected

  def common_errors
    %i[
      record_invalid
      update_invalid
      argument_error
      record_not_found
      parameter_missing
      bad_email_credentials
      bad_credentials
      user_not_found
      password_not_changed
      email_invalid
      email_not_found
    ]
  end

  ActionController::Renderers.add :error do |obj, options|
    render_error_response obj, error_model: options[:model],
                               http_status_code: options[:status],
                               message_variables: options[:message_variables] || {}
  end

  def force_json_format
    request.format = :json
  end

  def force_params_to_snakecase
    KeyTransformer.transform_snakecase! params
  end

  def render_error_response(error_key, error_model: nil, http_status_code: 400, message_variables: {})
    i18n_key = "api.errors.#{error_key}"

    i18n_variables = message_variables
    i18n_variables[:model] = error_model.model_name.human.presence || error_model.model_name if error_model

    error_json = {
      errorCode: I18n.t("#{i18n_key}.code"),
      message: I18n.t("#{i18n_key}.message", **i18n_variables),
      detail: ::ApiUtil.error_detail(error_model)
    }.as_json

    render json: error_json, status: http_status_code
  end
end
