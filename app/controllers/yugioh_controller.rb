class YugiohController < ApplicationController
  def index
    @yugioh_cards = YugiohCard.limit(20)
  end

  def search; end

  def show
    @yugioh_card = Product.find_by(id: params[:id]).productable
    return unless @yugioh_card.nil?

    redirect_to root_path
  end
end
