class Picture < ActiveRecord::Base
  attr_accessible :comment, :content_typ, :data, :name, :uploaded_picture
  validates_format_of :content_typ, with: /^image/, message: "--- you can only upload picture"

  def uploaded_picture=(picture_field)
    self.name = base_part_of(picture_field.original_filename)
    self.content_typ = picture_field.content_type.chomp
    self.data = picture_field.read
  end

  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/,'')
  end
end
