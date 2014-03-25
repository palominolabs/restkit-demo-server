module RmagickService

  class << self
    def resize_image(image, max_width, max_height)
      img_path = image.tempfile.path
      r_img = Magick::Image::read(img_path).first
      r_img.resize_to_fit!(max_width, max_height)
      r_img.to_blob
    end
  end
end