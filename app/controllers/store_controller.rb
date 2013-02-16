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
  layout nil, only: [:search]
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
    #@search = Product.search do 
    #  fulltext ActiveSupport::Inflector.transliterate(params[:search]).downcase
    #  with(:published_at).less_than(Time.zone.now)
    #  facet(:publish_month)
    #  with(:publish_month, params[:month]) if params[:month].present?
    #end

    term = ActiveSupport::Inflector.transliterate(params[:term]).downcase
    words = term.split(/\s/)
    prefix = words.pop
    full_words = words.join('')
    all_fields = [:title, :description]

    list = Sunspot.search(Product) do
      keywords(full_words, field: all_fields)
      text_fields do |text_fields_query|
        text_fields_query.any_of do |any_of_query|
          all_fields.each do |text_field|
            any_of_query.with(text_field).starting_with(prefix.downcase)
          end
        end
      end
    end
    @data = []

    list.each_hit_with_result do |hit, result|
      @data << {label: result.title,
                id: result.id,
                value: result.title,
                description: "#{ result.title }<br />#{ result.description }",
                link: products_path(result)
               }  
    end
    #@products = @search.results
    @visit = incrise_visit
    #render :index

    respond_to do |format|
      format.json { render json: @data.uniq.to_json }
    end

    end
end
