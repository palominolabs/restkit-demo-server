require 'spec_helper'

describe AwsService do
  describe '#upload_beer_image' do
    context 'no image provided' do
      it 'should raise NoImageProvided RuntimeError' do
        expect{ AwsService.upload_beer_image(nil, FactoryGirl.build(:beer)) }.to raise_error(AwsService::NoImageProvided)
      end
    end

    context 'invalid file format' do
      it 'should raise InvalidImageFormat RuntimeError' do
        expect{ AwsService.upload_beer_image(double(content_type: 'text/html'), FactoryGirl.build(:beer)) }.to raise_error(AwsService::InvalidImageFormat)
      end
    end

    context 'image upload fails' do
      before do
        RmagickService.should_receive(:resize_image).with(anything, 50, 50).and_return(double(content_type: 'image/png'))
        bucket = double('bucket', objects: double('objects', :create => double(public_url: false)))
        buckets = {'pl-reviews-images-test' => bucket}
        AWS::S3.should_receive(:new).and_return(double('s3', buckets: buckets))
      end

      it 'should raise ImageUploadFailed RuntimeError' do
        expect{ AwsService.upload_beer_image(double(content_type: 'image/png'), FactoryGirl.build(:beer)) }.to raise_error(AwsService::ImageUploadFailed)
      end
    end

    context 'image upload succeeds' do
      before do
        RmagickService.should_receive(:resize_image).with(anything, 50, 50).and_return(double(content_type: 'image/png'))
        bucket = double('bucket', objects: double('objects', create: double('create', public_url: 'test_url')))
        buckets = {'pl-reviews-images-test' => bucket}
        AWS::S3.should_receive(:new).and_return(double('s3', buckets: buckets))
      end

      it 'should return the new public_url for the uploaded image' do
        AwsService.upload_beer_image(double(content_type: 'image/png'), FactoryGirl.build(:beer)).should eql 'test_url'
      end

      context 'beer fails to save' do
        it 'should raise BeerSaveFailed RuntimeError' do
          Beer.any_instance.should_receive(:save).and_return(false)
          expect{ AwsService.upload_beer_image(double(content_type: 'image/png'), FactoryGirl.build(:beer)) }.to raise_error(AwsService::BeerSaveFailed)
        end
      end
    end
  end
end