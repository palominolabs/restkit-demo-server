module AwsService
  ACCEPTED_FORMATS = ['image/jpeg', 'image/png']
  IMAGE_BUCKET_NAME = "pl-reviews-images-#{Rails.env}"
  BASE_BEER_IMAGE_NAME = 'beer-thumb-'

  class ImageUploadFailed < RuntimeError
  end

  class InvalidImageFormat < RuntimeError
  end

  class NoImageProvided < RuntimeError
  end

  class << self
    def upload_beer_image(image, beer)
      if image
        if ACCEPTED_FORMATS.include?(image.content_type)
          s3 = AWS::S3.new
          bucket = s3.buckets[IMAGE_BUCKET_NAME]
          s3_image = bucket.objects.create(BASE_BEER_IMAGE_NAME + beer.id.to_s, image)

          if s3_image && s3_image.public_url
            s3_image.public_url
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
  end
end