require 'spec_helper'

describe User do
  it 'should have a PhotoUploader calld photo' do
    should have_column(:photo)
    @user = Factory(:user)
    @user.photo.should be_kind_of(PhotoUploader)
  end
  
  should_validate_presence_of(:name)
  
end
