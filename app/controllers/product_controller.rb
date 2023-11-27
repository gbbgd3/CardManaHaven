class ProductController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(30)
  end

  def search
    @category = params[:category]
    @search = params[:search]
  end
end
