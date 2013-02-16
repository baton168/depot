#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title, :published_at, :comments_attributes
  has_many :line_items
  has_many :orders, through: :line_items
  has_many :comments
  accepts_nested_attributes_for :comments, reject_if: :all_blank
  before_destroy :ensure_not_referenced_by_any_line_item

  
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
# 
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\Z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, length: {minimum: 10}

  scope :published, lambda{where('published_at <= ?', Time.zone.now)}
  searchable do
    text :title, boost: 5 do 
      transliterate(self.title)
    end
    text :description do 
      transliterate(self.description)
    end
    text :publish_month
    text :comments do
      comments.map do |comment|
        transliterate(comment.content)
      #comments.map(&:content)
      #comments.map { |c| c.content } to samo co linijka wyzej
      end
    end
    time :published_at
    string :publish_month
  end


  def publish_month
    published_at.strftime("%B %Y")
  end

  private
    def transliterate(param)
      ActiveSupport::Inflector.transliterate(param).downcase
    end
    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
