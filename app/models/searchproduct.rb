class SearchProduct
  #attr_reader :results
  def initialize(params)
    Product.search do 
      fulltext ActiveSuport::Inflector.transliterate(params[:search]).downcase
      with(:published_at).less_than(Time.zone.now)
      facet(:publish_month)
      with(:publish_month, params[:month]) if params[:month].present?
    end
  end

  def results
  
  end
end