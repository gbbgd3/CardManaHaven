class HomeController < ApplicationController
    def index
      @products_on_sale = Product.where('sale_price_cents < price_cents').limit(9).reorder('updated_at DESC')
    end
end
