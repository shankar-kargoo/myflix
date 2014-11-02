require 'spec_helper'

describe Video do
  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
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
