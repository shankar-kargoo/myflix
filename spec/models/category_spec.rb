require 'spec_helper'

describe Category do
  it {should have_many(:videos)}

  describe "#recent_videos" do 
    
    it "returns videos in reverse cronological order" do 
      comedies = Category.create(name: "comedies")
      futurama = Video.create(title: "futurama", description: "space travel", created_at: 1.day.ago)
      futurama.categories << comedies
      back_to_future = Video.create(title: "back to future ", description: "time travel")
      back_to_future.categories << comedies
      expect(comedies.recent_videos).to eq([back_to_future, futurama])
    end

    it "returns 6 videos if there are more than 6 videos" do 
      comedies = Category.create(name: "comedies")
      4.times do 
        futurama = Video.create(title: "futurama", description: "space travel", created_at: 1.day.ago)
        futurama.categories << comedies
      end
      4.times do 
        back_to_future = Video.create(title: "back to future ", description: "time travel")
        back_to_future.categories << comedies
      end
      expect(comedies.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      comedies = Category.create(name: "comedies")
      6.times do 
        futurama = Video.create(title: "futurama", description: "space travel")
        futurama.categories << comedies
      end
      back_to_future = Video.create(title: "back to future ", description: "time travel", created_at: 1.day.ago)
      back_to_future.categories << comedies
      
      expect(comedies.recent_videos).not_to include(back_to_future)
    end

    it "returns an empty array if category does not have any videos" do 
      comedies = Category.create(name: "comedies")
      expect(comedies.recent_videos.count).to eq(0)
    end

  end
end

# describe Category do
#   it 'Category can saves itself' do
#     category = Category.new(name: "comedies")
#     category.save
#     expect(Category.first).to eq(category)
#   end

#   it "Category can have many videos" do
#     category = Category.new(name: "comedies")
#     video1 = Video.new(title: "Southpark", description: "Funny videos", category: comedies)
#     video2 = Video.new(title: "Northpark", description: "Appartment complex story", category: comedies)
#     expect(comedies.videos).to eq(Northpark, Southpark)
#   end
# end
