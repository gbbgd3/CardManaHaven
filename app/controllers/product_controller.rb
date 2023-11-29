class ProductController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(30)
  end

  def search
    @category = Category.find_by(id: params[:category])
    @search = params[:search]
    @sort_order = params[:sort_order]

  end
end
