Paperclip.interpolates(:s3_sg_url) { |attachment, style|
   "#{attachment.s3_protocol}://s3-ap-southeast-1.amazonaws.com/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/},
   "")}"
   }