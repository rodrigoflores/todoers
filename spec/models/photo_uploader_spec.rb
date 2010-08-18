require 'spec_helper'
require 'carrierwave/test/matchers'

describe PhotoUploader do
  before do
    @user = Factory(:user)
    PhotoUploader.enable_processing = true
    @uploader = PhotoUploader.new(@user, :photo)
    @uploader.store!(File.open('public/images/rails.png','r'))
  end
  
  it "should not allow files that are not photos" do
    @another_uploader = PhotoUploader.new(@user, :photo)
    lambda { 
      @uploader.store!(File.open('config.ru','r'))
    }.should raise_exception
  end
  
  it "should allow photos" do
    @another_uploader = PhotoUploader.new(@user, :photo)
    lambda { 
      @uploader.store!(File.open('public/images/rails.png','r'))
    }.should_not raise_exception
  end
  
  after do
    PhotoUploader.enable_processing = false
  end
end