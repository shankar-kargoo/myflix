# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
comedies = Category.create(name: "comedies")
video = Video.create(title: "Family Guy", description: "Story of a great family",small_cover_url: "/tmp/family_guy.jpg")
video.categories << comedies
video = Video.create(title: "Futurama", description: "A cartoon story",small_cover_url: "/tmp/futurama.jpg")
video.categories << comedies
video = Video.create(title: "south_park", description: "Story of a park",small_cover_url: "/tmp/south_park.jpg")
video.categories << comedies
video = Video.create(title: "Monk", description: "A detective's story",small_cover_url: "/tmp/monk.jpg", large_cover_url:"public/tmp/monk_large.jpg")
video.categories << comedies
video = Video.create(title: "Family Guy", description: "Story of a great family",small_cover_url: "/tmp/family_guy.jpg")
video.categories << comedies
video = Video.create(title: "Futurama", description: "A cartoon story",small_cover_url: "/tmp/futurama.jpg")
video.categories << comedies
video = Video.create(title: "south_park", description: "Story of a park",small_cover_url: "/tmp/south_park.jpg")
video.categories << comedies
video = Video.create(title: "Monk", description: "A detective's story",small_cover_url: "/tmp/monk.jpg", large_cover_url:"public/tmp/monk_large.jpg")
video.categories << comedies

humor = Category.create(name: "Humor")
guy = Video.create(title: "Family Guy", description: "Story of a great family",small_cover_url: "/tmp/family_guy.jpg")
guy.categories << humor
video = Video.create(title: "Futurama", description: "A cartoon story",small_cover_url: "/tmp/futurama.jpg")
video.categories << humor
video = Video.create(title: "south_park", description: "Story of a park",small_cover_url: "/tmp/south_park.jpg")
video.categories << humor
monk = Video.create(title: "Monk", description: "A detective's story",small_cover_url: "/tmp/monk.jpg", large_cover_url:"public/tmp/monk_large.jpg")
monk.categories << humor

vichu = User.create(full_name: "Vishwath Krisha", password: "password", email:"vichu@example.com")

Review.create(user: vichu, video: guy, rating: 5, content: "This is a really funny series" )
Review.create(user: vichu, video: guy, rating: 2, content: "This is a too real to be true" )