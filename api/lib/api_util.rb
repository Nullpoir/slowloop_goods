module ApiUtil
  module_function

  def error_detail(error_model)
    if !error_model || error_model.errors.blank?
      {}
    else
      error_model.errors.attribute_names.to_h do |k|
          [k.to_s.camelize(:lower).to_sym, error_model.errors.full_messages_for(k)]
        end
    end
  end
end
