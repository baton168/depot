class Comment < ActiveRecord::Base
  belongs_to :product
  attr_accessible :content, :rate

  RATES=(1..5).to_a

  validates :rate, numericality: { within: RATES, allow_blank: true }
end
