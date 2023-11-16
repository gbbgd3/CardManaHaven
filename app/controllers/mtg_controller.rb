class MtgController < ApplicationController


    def show
        @card = Mtg.find_by(id: params[:id])
    end
end
