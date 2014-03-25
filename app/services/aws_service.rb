module AwsService
  JPEG_FORMAT = 'image/jpeg'
  PNG_FORMAT = 'image/png'
  ACCEPTED_FORMATS = [JPEG_FORMAT, PNG_FORMAT]
  IMAGE_BUCKET_NAME = "pl-reviews-images-#{Rails.env}"
  BASE_BEER_IMAGE_NAME = 'beer-thumb-'
  MAX_WIDTH = 50
  MAX_HEIGHT = 50

  class ImageUploadFailed < RuntimeError
  end

  class InvalidImageFormat < RuntimeError
  end

  class NoImageProvided < RuntimeError
  end

  class BeerSaveFailed < RuntimeError
  end

  class << self
    def upload_beer_image(image, beer)
      if image
        if ACCEPTED_FORMATS.include?(image.content_type)
          resized_image = RmagickService.resize_image(image, MAX_WIDTH, MAX_HEIGHT)
          s3 = AWS::S3.new
          bucket = s3.buckets[IMAGE_BUCKET_NAME]

          extension = get_image_extension(image)
          s3_filename = BASE_BEER_IMAGE_NAME + beer.id.to_s + extension

          s3_image = bucket.objects.create(s3_filename, resized_image)

          if s3_image && s3_image.public_url
            beer.image_url = s3_image.public_url.to_s
            if beer.save
              s3_image.public_url
            else
              raise BeerSaveFailed
            end
          else
            raise ImageUploadFailed
          end
        else
          raise InvalidImageFormat
        end
      else
        raise NoImageProvided
      end
    end

    private
    def get_image_extension(image)
      if image.content_type == JPEG_FORMAT
        '.jpeg'
      elsif image.content_type == PNG_FORMAT
        '.png'
      end
    end
  end
end