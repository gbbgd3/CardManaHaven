class CartController < ApplicationController
  before_action :check_user
  before_action :load_cart, only: %i[show_cart add_to_cart remove_item update_quantity]

  def show_cart
    @cart_items
    @total_price = !@cart_items.empty? ? calculate_total_price : 0
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
    item = @cart.find { |product| product["id"] == id }
    item["quantity"] = quantity if item
    redirect_back(fallback_location: root_path)
  end

  private

  def check_user
    redirect_to new_user_session_path unless user_signed_in?
  end

  def load_cart
    @cart = session[:cart] ||= []
    @cart_items = build_cart_items
  end

  def build_cart_items
    return [] unless session[:cart]

    session[:cart].map do |item|
      product = Product.find_by(id: item["id"].to_i)
      { product:, quantity: item["quantity"].to_i }
    end
  end

  def calculate_total_price
    @cart.sum do |item|
      product = Product.find_by(id: item["id"].to_i)
      price_cents = (product.sale_price_cents < product.price_cents) ? product.sale_price_cents : product.price_cents
      puts "Price_cents before Tax and qty #{price_cents}"
      taxed_price = price_cents + price_cents * (current_user.province.total_tax_rate / 100)
      puts "Price_cents after Tax and not qty #{taxed_price}"
      taxed_price * item["quantity"].to_i
    end
  end  
end
