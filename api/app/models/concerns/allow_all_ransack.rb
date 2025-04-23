module AllowAllRansack
  def self.ransackable_attributes(_auth_object = nil)
    column_names + _ransackers.keys
  end

  def self.ransackable_associations(_auth_object = nil)
    reflect_on_all_associations.map { |a| a.name.to_s } + _ransackers.keys
  end
end
