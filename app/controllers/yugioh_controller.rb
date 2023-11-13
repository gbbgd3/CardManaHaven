class YugiohController < ApplicationController
    def index
      @yugioh_cards = YugiohCard.limit(25)
    end
end
