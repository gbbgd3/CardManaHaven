class YugiohController < ApplicationController
    def index
      @yugioh_cards = YugiohCard.limit(60)
    end

    def search
    end
end
