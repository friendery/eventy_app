# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['event_avatar']
  
  version :standard do
    process :resize_to_fill => [150, 150, :north]
  end
  
  version :thumbnail do
    resize_to_fit(100, 100)
  end
  
  version :icon do
    resize_to_fit(50, 50)
  end

end
