module KeyTransformer
  module_function

  def transform_snakecase!(obj)
    case obj
    when Array
      obj.map { |e| transform_snakecase! e }
    when Hash, ActionController::Parameters
      obj.transform_keys!(&:underscore)
      obj.transform_values! do |v|
        transform_snakecase! v
      end
    else
      obj
    end
  end

  def transform_camel_lower(value)
    case value
    when Hash
      value.deep_transform_keys! { |key| transform_camel_lower(key) }
    when Symbol
      transform_camel_lower(value.to_s).to_sym
    when String
      value.underscore.camelize(:lower)
    else
      value
    end
  end
end
