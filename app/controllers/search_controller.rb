class SearchController  < ApplicationController
  def search_redirect
    id = params[:category].to_i
    search = params[:search].to_s
    sort_order = params[:sort].present? ? params[:sort].to_i : 0
    c= Category.find_by(id: id)
    if c
      redirect_to send("#{(CGI.escape(c.name).downcase).gsub('+', '_')}_search_path", search: search, category: c, sort: sort_order)
      return
    end
    redirect_to products_search_path(search: search)
  end
end