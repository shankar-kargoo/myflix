require 'spec_helper'

describe Video do
  it { should have_many(:categories)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it {should have_many(:reviews).order("created_at DESC")}
  
  describe do 
    it "returns a empty array if there is no match" do 
      futurama = Video.create(title: "futurama", description: "space travel")
      back_to_future = Video.create(title: "back to future ", description: "time travel")
      expect(Video.search_by_title("hello")).to eq([])
    end
    
    it "returns a empty array if empty search" do 
      futurama = Video.create(title: "futurama", description: "space travel")
      back_to_future = Video.create(title: "back to future ", description: "time travel")
      expect(Video.search_by_title("")).to eq([])
    end

    it "returns an array of one video for an exact match" do
      futurama = Video.create(title: "Futurama", description: "space travel")
      back_to_future = Video.create(title: "back to future ", description: "time travel")
      expect(Video.search_by_title("Futurama")).to eq([futurama])
    end

    it "returns an array of one video for partial match" do
      futurama = Video.create(title: "Futurama", description: "space travel")
      back_to_future = Video.create(title: "back to future ", description: "time travel")
      expect(Video.search_by_title("rama")).to eq([futurama])
    end

    it "returns an array for partial match ordered by created_at" do
      futurama = Video.create(title: "Futurama", description: "space travel", created_at: 1.day.ago)
      back_to_future = Video.create(title: "Back to Future ", description: "time travel")
      expect(Video.search_by_title("Futur")).to eq([back_to_future, futurama])
    end

  end
end


# describe Video do
#   it 'Video saves itself' do
#     video = Video.new(title: "Monk", description: "A great story")
#     video.save
#     expect(Video.first).to eq(video)
#   end

#   it 'Videos belong to a category'
#     drama = Category.create(name: "dramas")
#     monk = Video.create(title: "Monk", description: "A great story", category: dramas)
#     expect(monk.category).to eq(dramas)
#   end

#   it 'Videos mandates a title'
#     monk = Video.create(description: "A great story")
#     expect(Video.count).to eq(0)
#   end

#   it 'Videos mandates description'
#     drama = Category.create(name: "dramas")
#     monk = Video.create(title: "Monk")
#     expect(Video.count).to eq(0)
#   end

# end
