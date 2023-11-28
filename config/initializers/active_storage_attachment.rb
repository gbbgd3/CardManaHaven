ActiveSupport.on_load(:active_storage_attachment) do
  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes
  end
end