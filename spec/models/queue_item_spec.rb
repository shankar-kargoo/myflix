require 'spec_helper'

describe QueueItem do
  it {should belong_to (:user)}
  it {should belong_to (:video)}
  it {should validate_numericality_of(:position).only_integer }

  describe "#video_title" do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: 'Monk')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Monk')
    end
  end

  describe "#rating" do
    it "should return the users rating of the video" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 4)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(4)
    end

    
    it "returns nil when review is not present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe "#rating=" do
    it "Could change the rating of the review when present" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 2)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      queue_item.rating = 4
      expect(Review.first.rating).to eq(4)
    end


    it "Could detete the rating of a review if user chooses to" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 2)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end

    it "Could create a new review with a rating if video was previously unrated" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      queue_item.rating = 4
      expect(Review.first.rating).to eq(4)

    end

  end


end
