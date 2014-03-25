require 'spec_helper'

describe RmagickService do
 describe '#resize_path' do
   it 'returns a blob' do
     read_stub = double('read', first: double('first', resize_to_fit!: double('resize_to_fit!')))
     read_stub.first.should_receive(:to_blob).and_return('blob')
     image = double('image', tempfile: double('tempfile', path: 'path'))
     Magick::Image.should_receive(:read).with('path').and_return(read_stub)
     RmagickService.resize_image(image, 50, 50).should eql 'blob'
   end
 end
end