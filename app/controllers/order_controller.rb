class OrderController < ApplicationController
  def index
    @orders = current_user.orders.includes(:order_products)
  end
end
