class AddPublishedAtToProduct < ActiveRecord::Migration
  def change
    add_column :products, :published_at, :datetime
  end
end
