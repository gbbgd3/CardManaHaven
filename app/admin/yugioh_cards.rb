ActiveAdmin.register YugiohCard do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :card_id, :name, :card_type, :level, :attribute_of_card, :archetype, :description_of_card, :atk, :def, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:card_id, :name, :card_type, :level, :attribute_of_card, :archetype, :description_of_card, :atk, :def, :image]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form do |f|
    f.inputs 'YugiohCard Details' do
      f.input :name
      f.input :card_type
      f.input :level
      f.input :attribute_of_card
      f.input :archetype
      f.input :description_of_card
      f.input :atk
      f.input :def
      f.input :image
      f.input :yugioh_sets, as: :select, input_html: { multiple: true }, collection: YugiohSet.all.map { |set| [set.set_name, set.id] }
    end
    f.actions
  end
end
