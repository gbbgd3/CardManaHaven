class YugiohController < ApplicationController
    def index
      @yugioh_cards = YugiohCard.limit(60)
    end

    def search
    end

    def show
      @card = YugiohCard.find_by(id: params[:id])
    end
end
