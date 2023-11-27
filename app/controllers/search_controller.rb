class SearchController  < ApplicationController
  def search_redirect
    id = params[:category].to_i
    search = params[:search].to_s
    c= Category.find_by(id: id)

    if c
    redirect_to send("#{(CGI.escape(c.name).downcase).gsub('+', '_')}_search_path", search: search)
    return
    end
    redirect_to products_search_path(search: search)
  end
end