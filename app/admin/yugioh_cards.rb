ActiveAdmin.register YugiohCard do
  permit_params :card_id, :name, :card_type, :level, :attribute_of_card, :archetype, 
                :description_of_card, :atk, :def, :image, :product_id, yugioh_set_ids:[],
                yugioh_card_sets_attributes: [:id, :yugioh_set_id, :set_code, :set_rarity, :_destroy]
  show do
    attributes_table do
      row :name
      row :card_type
      row :level
      row :attribute_of_card
      row :archetype
      row :description_of_card
      row :atk
      row :def
      row :image
      row :product
    end

    panel 'Yugioh Sets' do
      if yugioh_card.yugioh_sets.present?
      table_for yugioh_card.yugioh_sets do
        column 'Set Name', &:set_name
      end
      end
    end
  end

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
      f.has_many :yugioh_card_sets, allow_destroy: true do |cf|
        cf.input :yugioh_set, as: :select, input_html: { multiple: false }, collection: YugiohSet.all.map { |set| [set.set_name, set.id] }
        cf.input :set_code
        cf.input :set_rarity
      end
    end
    f.actions
  end
end