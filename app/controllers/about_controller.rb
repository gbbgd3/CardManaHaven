class AboutController < ApplicationController
  def index
    @about_page = About.first
  end
end 