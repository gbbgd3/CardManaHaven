ActiveAdmin.register Product do
  permit_params :productable_type, :category_id, :price_cents, :sale_price_cents,
                :product_detail, :image_url, :stock,
                :product_name, :brand, :productable_id, :image

  form do |f|
    f.inputs 'Product Details' do
      f.input :category
      f.input :price_cents
      f.input :sale_price_cents
      f.input :product_detail
      f.input :image, as: :file
      f.input :stock
      f.input :product_name
      f.input :brand
      f.input :productable_type, as: :select, collection: [YugiohCard.name, Mtg.name]
      f.input :productable_id, as: :select, collection: YugiohCard.all.map { |card| [card.name, card.id] }    
    end
    f.actions
  end
end
