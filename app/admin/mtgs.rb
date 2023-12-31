ActiveAdmin.register Mtg do
  menu label: 'Magic The Gathering Cards'
  permit_params :name, :mana, :type_line, :oracle_text, :flavour_text, :artist_id, :layout, :power, :toughness, :m_set_id,
                 card_face_ids: [], card_faces_attributes: [:id, :name, :_destroy]

  form do |f|
    f.inputs do
      f.input :name
      f.input :mana
      f.input :type_line
      f.input :oracle_text
      f.input :flavour_text
      f.input :layout
      f.input :power
      f.input :toughness
      f.input :artist
      f.input :m_set
      f.inputs 'Card Faces' do
        if !f.object.persisted?
          f.has_many :card_faces, new_record: 'Add Card Face' do |cf|
            cf.input :name
            cf.input :mana
            cf.input :type_line
            cf.input :oracle_text
            cf.input :flavour_text
            cf.input :power
            cf.input :toughness
          end
        end
          f.input :card_face_ids, as: :check_boxes, collection: CardFace.all.map { |cf| [cf.name, cf.id] }, input_html: { multiple: true, allow_blank: true }
        end
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :mana
      row :type_line
      row :oracle_text
      row :flavour_text
      row :layout
      row :power
      row :artist
      row :m_set
      row :card_faces do |mtg|
        mtg.card_faces.map { |card_face| link_to(card_face.name, admin_card_face_path(card_face)) }.join(', ').html_safe
      end
    end
    active_admin_comments
  end

  index do
    selectable_column
    column :name
    column :mana
    column :type_line
    column :oracle_text
    column :flavour_text
    column :layout
    column :power
    column :artist
    column :m_set
    column :card_faces do |mtg|
      mtg.card_faces.map(&:name).join(', ')
    end
    actions
  end
end
