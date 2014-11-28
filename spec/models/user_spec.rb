require 'spec_helper'

describe User do
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:full_name)}
  it {should validate_presence_of(:email)}
  it {should have_many(:queue_items).order(:position)}

  describe "#queued_video?" do
    it "returns true when user queued the video" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      Fabricate(:queue_item, user: user, video: video)
      user.queued_video?(video).should be_true
    end

    it "returns false when user hasn't queued the video" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      user.queued_video?(video).should be_false
    end
  end

end
