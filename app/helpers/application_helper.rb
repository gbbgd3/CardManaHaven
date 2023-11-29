module ApplicationHelper
  def product_show_path(product)
    case product.productable.class.name
    when YugiohCard.name
      yugioh_card_path(product.id)
    when Mtg.name
      magic_the_gathering_card_path(product.id)
    else
      root_path
    end
  end
end
