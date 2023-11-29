class HomeController < ApplicationController
  def index
    @yugioh_products_on_sale = Product.where(category: Category.find_by(name: "Yugioh")).where("sale_price_cents < price_cents").limit(9)
    @magic_prodcuts_on_sale = Product.where(category: Category.find_by(name: "Magic The Gathering")).where("sale_price_cents < price_cents").limit(9)
  end
end
