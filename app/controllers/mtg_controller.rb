class MtgController < ApplicationController
  def show
    @card = Product.find_by(id: params[:id])
    @card = @card.productable
  end

  def search; end
end
