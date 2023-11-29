class ProductController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(30)
    @products_total = Product.all.count
  end

  def search
    @category = Category.find_by(id: params[:category])
    @search = params[:search]
    @sort_order = params[:sort].to_i
    @products = Product.all
    case @sort_order
    when 1 # sale
      @products = @products.where("price_cents > sale_price_cents")
    when 2 # new
      @products = @products.where("created_at >= ?", 3.days.ago).order(created_at: :desc)
    end
    @products = @products.where(category: @category) if @category.present?
    @products = @products.where("product_name LIKE ?", "%#{@search}%")
    @products_total = @products.count
    @products = @products.where("product_name LIKE ?", "%#{@search}%").page(params[:page]).per(30)
  end
end
