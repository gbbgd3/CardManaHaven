ActiveAdmin.register CardFace do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
    permit_params :name, :mana, :type_line, :oracle_text, :power, :toughness, :image, :flavour_text
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :mana, :type_line, :oracle_text, :power, :toughness, :image, :flavour_text]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
