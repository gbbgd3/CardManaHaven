ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :category_id, :price_cents, :sale_price_cents, :product_detail, :image_url, :stock, :product_name, :brand, :productable_type, :productable_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:category_id, :price_cents, :sale_price_cents, :product_detail, :image_url, :stock, :product_name, :brand, :productable_type, :productable_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  form do |f|
    f.inputs 'Product Details' do
      f.input :category
      f.input :price_cents
      f.input :sale_price_cents
      f.input :product_detail
      f.input :image_url
      f.input :stock
      f.input :product_name
      f.input :brand
      f.input :productable, as: :select, collection: controller.productable_options_for_select
    end
    f.actions
  end

  controller do
    def find_productables_without_product
      (YugiohCard.left_outer_joins(:product).where(products: { id: nil }) +
       Mtg.left_outer_joins(:product).where(products: { id: nil })).uniq
    end

    def productable_options_for_select
      find_productables_without_product.map do |record|
        if record.is_a?(YugiohCard)
          ["#{record.name}#{yugioh_card_set_info(record)} | YuGiOh", record.id]
        elsif record.is_a?(Mtg)
          ["#{record.name} | #{record.m_set.name} | MagicTheGathering", record.id]
        end
      end
    end
    def yugioh_card_set_info(yugioh_card)
      yugioh_card.yugioh_card_sets.present? ? " | #{yugioh_card.yugioh_card_sets[0].set_code}" : ""
    end
  end

end
