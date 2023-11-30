class CartController < ApplicationController
  before_action :load_cart, only: %i[show_cart add_to_cart remove_item update_quantity]

  def show_cart
    @cart_items
  end

  def add_to_cart
    id = params[:id].to_i
    @cart << { "id": id, "quantity": 1 } unless session[:cart].any? { |item| item["id"] == id }
    redirect_back(fallback_location: root_path)
  end

  def remove_item
    id = params[:id].to_i
    @cart.reject! { |item| item["id"].to_i == id }
    redirect_back(fallback_location: root_path)
  end

  def update_quantity
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    puts id
    puts quantity
    puts @cart.inspect
    item = @cart.find { |product| product["id"] == id }
    item["quantity"] = quantity if item
    redirect_back(fallback_location: root_path)
  end

  private

  def load_cart
    @cart_items = build_cart_items
    @cart = session[:cart] || []
  end

  def build_cart_items
    return [] unless session[:cart]

    session[:cart].map do |item|
      product = Product.find_by(id: item["id"].to_i)
      { product:, quantity: item["quantity"].to_i }
    end
  end
end
