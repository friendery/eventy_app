# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  
  version :standard do
    process :resize_to_fill => [150, 150, :north]
  end
  
  version :thumbnail do
    resize_to_fill(100, 100)
  end
  
  version :comment do
    resize_to_fill(75, 75)
  end
  
  version :icon do
    resize_to_fill(50, 50)
  end

  def default_url
    "/assets/event/" + [version_name, "default.png"].compact.join('_')
  end
end
