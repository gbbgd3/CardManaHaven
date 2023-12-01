ActiveAdmin.register Product do
  permit_params :productable_type, :category_id, :price_cents, :sale_price_cents,
                :product_detail, :image_url, :stock,
                :product_name, :brand, :productable_id, :image

  form do |f|
    f.inputs "Product Details" do
      f.input :category
      f.input :price_cents
      f.input :sale_price_cents
      f.input :product_detail
      f.input :image, as: :file
      f.input :stock
      f.input :product_name
      f.input :brand
      f.input :productable_type, as: :select, collection: [YugiohCard.name, Mtg.name]

      current_productable_id = f.object.productable_id

      productable_options = (YugiohCard.left_joins(:product).where(products: { id: nil }).to_a +
      Mtg.left_joins(:product).where(products: { id: nil }).to_a)
                            .uniq.map { |card| ["#{card.name} | #{card.class.name}", card.id] }

      if current_productable_id.present?
        productable_options << [f.object.productable.name, current_productable_id]
      end

      f.input :productable_id, as: :select, collection: productable_options
    end
    f.actions
  end

  show do
    attributes_table do
      row :category
      row :price_cents
      row :sale_price_cents
      row :product_detail
      row :image do |product|
        image_tag(product.image, width: "100px") if product.image.present?
      end
      row :stock
      row :product_name
      row :brand
      row :productable
    end

    active_admin_comments
  end
end
