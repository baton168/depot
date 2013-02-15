class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :comment
      t.string :name
      t.string :content_typ
      t.binary :data, limit: 1.megabyte

      t.timestamps
    end
  end
end
