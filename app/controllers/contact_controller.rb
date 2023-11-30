class ContactController < ApplicationController
  def index
    @contact_page = Contact.first
  end
end