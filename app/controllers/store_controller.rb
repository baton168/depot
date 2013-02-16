#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class StoreController < ApplicationController
  skip_before_filter :authorize, :search
  def index
    @products = Product.published.order(:title)
    @cart = current_cart
    @visit = incrise_visit
  end

  def incrise_visit
    session[:visit_counter] ||= 0
    @visit = session[:visit_counter] += 1
  end

  def search
    @search = Product.search do 
      fulltext params[:search]
      with(:published_at).less_than(Time.zone.now)
      facet(:publish_month)
      if params[:month].present?
        with(:publish_month, params[:month])
      end
    end
    @products = @search.results
    @visit = incrise_visit
    render :index

  end
end
