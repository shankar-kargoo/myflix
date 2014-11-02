require 'spec_helper'

describe Category do
  it { should have_many(:videos)}
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
