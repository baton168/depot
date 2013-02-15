class UploadController < ApplicationController

  def save
    @picture=Picture.new(params[:picture])
    
    if @picture.save
      redirect_to action: 'show', id: @picture.id
    else
      render(action: :get)
    end
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def picture
    @picture = Picture.find(params[:id])
    send_data(@picture.data, filename: @picture.name, type: @picture.content_typ, disposition: "inline")
  end

  def get
    @picture = Picture.new
  end

  #def save_picture
  #end
end
