class ProductController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(30)
  end

  def show; end

  def search
    category_id = params[:category].to_i
    if category_id.zero?
      @search = params[:search].to_s
    elsif Category.exists?(id: category_id)
      redirect_to send("#{Category.find_by(id: category_id).name.downcase}_search_path",
                       search: params[:search])
    end
  end
end
