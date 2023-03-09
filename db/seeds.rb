# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ADDRESSES = ['Rudi-Dutschke-Straße 26, 10969 Berlin']

require 'open-uri'
require 'faker'

# puts 'droopping the database'
# p `rails db:drop`

# puts 'Creating the database'
# puts `rails db:create`

# puts 'Migrating the database'
# puts `rails db:migrate`

# puts 'Starting the Seed!'
puts 'Destroying all Product'
Product.destroy_all

puts 'Destroying all Users'
User.destroy_all

puts "Creating Users..."
amin = User.create(email: 'amin@amin.com', password: '123456', username: 'aminTheBest', first_name: 'amin', last_name: 'ahcene')
amin.photo.attach(io: File.open(File.join(Rails.root,'app/assets/images/amin.jfif')),
                  filename: "amin.jfif", content_type: "image/jfif")

alex = User.create(email: 'alex@alex.com', password: '123456', username: 'alexTheBest', first_name: 'alex', last_name: 'wenzel')
alex.photo.attach(io: File.open(File.join(Rails.root,'app/assets/images/alex.jfif')),
                  filename: "alex.jfif", content_type: "image/jfif")

osama = User.create(email: 'osama@osama.com', password: '123456', username: 'osamaTheKing', first_name: 'osama', last_name: 'shehata')
osama.photo.attach(io: File.open(File.join(Rails.root,'app/assets/images/osama.jfif')),
                  filename: "osama.jfif", content_type: "image/jfif")

fadi = User.create(email: 'fadi@fadi.com', password: '123456', username: 'fadiFedo', first_name: 'fadi', last_name: 'bibawy')
fadi.photo.attach(io: File.open(File.join(Rails.root,'app/assets/images/fadi.jfif')),
                  filename: "fadi.jfif", content_type: "image/jfif")

puts '---------------------------------'

puts "Creating Products..."
5.times do
  url = "https://picsum.photos/300/400"
  file = URI.open(url)
  quality = ["good", "very good", "fair", "not bad"]
  address = ['Rudi-Dutschke-Straße 26, 10969 Berlin', '16 Vla Gaudelet, 75011 Paris, France', 'C/ del Bruc, 149, 08037 Barcelona, Spain', '380 Bd Brahim Roudani, Casablanca, Morocco']
  category = ['service', 'goods']
  service = ['cleaning', 'repair', 'maintenance']
  goods = ['clothes', 'furniture', 'electronics', 'books']

  product = Product.new(title: Faker::Commerce.product_name,
                        description: "#{Faker::Commerce.material}\n#{Faker::Commerce.color}",
                        category: category.sample,
                        subcategory: category == 'service' ? service.sample : goods.sample,
                        quality: quality.sample,
                        address: address.sample)

  product.photos.attach(io: file, filename: "#{rand(1.5..3.0)}image.png", content_type: "image/png")
  product.user = User.all.sample
  product.save
  puts "#{product.title} created"
end
puts ""
puts "All Products Created!"

# img_urls = [
#   "https://images.unsplash.com/photo-1502471074209-74d89da65ef2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
#   "https://images.unsplash.com/photo-1526394931762-90052e97b376?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
#   "https://images.unsplash.com/photo-1535992165812-68d1861aa71e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=390&q=80",
#   "https://images.unsplash.com/photo-1452639479057-3f773899ab7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
#   "https://images.unsplash.com/photo-1619983081563-430f63602796?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
#   "https://images.unsplash.com/photo-1492284163710-4eef97892705?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80",
#   "https://images.unsplash.com/photo-1491421722235-b556e8f64dab?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
#   "https://images.unsplash.com/photo-1514846160150-2cfb150b48ea?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=393&q=80",
#   "https://images.unsplash.com/photo-1496293455970-f8581aae0e3b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=813&q=80"
# ]

# quality = ["good", "very good", "fair", "not bad"]

# Vinyl.destroy_all
# puts "Starting the seed!"
# img_urls.each_with_index do |img_url, index|
#   file = URI.open(img_url)
#   vinyl = Vinyl.new(artist: Faker::Music::Hiphop.artist, release_year: rand(1950..2010), genre: Faker::Music.genre, quality: quality.sample,
#                     record_title: Faker::Music::Opera.mozart, price_per_day: rand(8.5..32.25).round(2))
#   vinyl.photo.attach(io: file, filename: "#{rand(1.5..3.0)}image.png", content_type: "image/png")
#   vinyl.user = User.all.sample
#   vinyl.save
#   puts "#{vinyl.record_title.capitalize} created successfully!"
# end
# puts "All Vinyls created!"
