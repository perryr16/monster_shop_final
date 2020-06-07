# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Review.destroy_all
Merchant.destroy_all
Item.destroy_all
Order.destroy_all
User.destroy_all
#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

computer_shop = Merchant.create(name: "Zed's Computers", address: '125 Computer St.', city: 'Denver', state: 'CO', zip: 81111)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
helmet = bike_shop.items.create(name: "Helmet", description: "Safety first", price: 150, image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/HLXM2_AV4?wid=1144&hei=1144&fmt=jpeg&qlt=95&op_usm=0.5,0.5&.v=1522357479494", inventory: 10)
bicycle = bike_shop.items.create(name: "Bicycle", description: "Mountain bike", price: 800, image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/canyon-strive-29-tested-1577145399.jpg?crop=0.889xw:1.00xh;0.0705xw,0&resize=640:*", inventory: 3)
tire_iron = bike_shop.items.create(name: "Tire Iron", description: "Does the job", price: 10, image: "https://www.somafab.com/wp-description/uploads/2011/06/tirelever_core_full_lever4c1.jpg", inventory: 10, active: false)

#bike_shop item reviews
review1 = tire.reviews.create(title: "Great tire", description: "Will buy this tire again", rating: 4)
review2 = helmet.reviews.create(title: "Cool helmet", description: "Very safe", rating: 3)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "https://m.media-amazon.com/images/I/61lYdX-EdfL._AC_SS350_.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
dog_food = dog_shop.items.create(name: "Dog Food", description: "Super tasty", price: 30, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRgRJErkeYhfadwU8k2Jux0Hhp7KsvijgO61Ia2T__NWpPl3cLZ&usqp=CAU", inventory: 15)
dog_pram = dog_shop.items.create(name: "Dog pram", description: "Carry your dog in style", price: 200, image: "https://assets.petco.com/petco/image/upload/f_auto,q_auto,t_ProductDetail-large/2327664-center-2", inventory: 10, active: false)

#dog_shop item reviews
review3 = pull_toy.reviews.create(title: "Crappy pull toy", description: "Dog hates this", rating: 1)
review4 = dog_food.reviews.create(title: "Mediocore dog food", description: "Dog doesn't love it or hate it", rating: 2)
review5 = dog_food.reviews.create(title: "Good, not great dog food", description: "Acceptable for my dog", rating: 4)


#computer_shop items
laptop = computer_shop.items.create(name: "Laptop", description: "Fastest computer around!", price: 1000, image: "https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6356/6356671_sd.jpg", inventory: 20)
keyboard = computer_shop.items.create(name: "Keyboard", description: "Bluetooth keyboard", price: 50, image: "https://images-na.ssl-images-amazon.com/images/I/81PLqxtrJ3L._AC_SL1500_.jpg", inventory: 15)
mouse = computer_shop.items.create(name: "Mouse", description: "Bluetooth mouse", price: 40, image: "https://www.staples-3p.com/s7/is/image/Staples/s1020457_sc7?wid=512&hei=512", inventory: 13)
carrying_case = computer_shop.items.create(name: "Laptop carrying case", description: "Keep your laptop safe", price: 75, image: "https://static.bhphoto.com/images/images2500x2500/1422621364_1116114.jpg", inventory: 13, active: false)

#computer_shop reviews
review6 = laptop.reviews.create(title: "Great laptop", description: "Love it", rating: 4)
review7 = laptop.reviews.create(title: "Decent laptop", description: "Love it", rating: 3)
review8 = keyboard.reviews.create(title: "Decent keyboard", description: "Does the job", rating: 3)
review9 = mouse.reviews.create(title: "Decent mouse", description: "Does the job", rating: 3)

#Users
regular1 = User.create!(name: "User Name1", address: "user address1", city: "user city", state: "state", zip: "user zip", email: "user1", password: "user", role: 0)
regular2 = User.create!(name: "User Name2", address: "user address2", city: "user city", state: "state", zip: "user zip", email: "user2", password: "user", role: 0)
regular3 = User.create!(name: "User Name3", address: "user address3", city: "user city", state: "state", zip: "user zip", email: "user3", password: "user", role: 0)
merchant1 = User.create!(name: "Merchant Name1", address: "merchant address", city: "merchant city", state: "state", zip: "merchant zip", email: "merchant_bike", password: "merchant", role: 1, merchant_id: bike_shop.id)
merchant2 = User.create!(name: "Merchant Name2", address: "merchant address", city: "merchant city", state: "state", zip: "merchant zip", email: "merchant_dog", password: "merchant", role: 1, merchant_id: dog_shop.id)
merchant3 = User.create!(name: "Merchant Name3", address: "merchant address", city: "merchant city", state: "state", zip: "merchant zip", email: "merchant_computer", password: "merchant", role: 1, merchant_id: computer_shop.id)
admin1 = User.create!(name: "Admin Name1", address: "admin address", city: "admin city", state: "state", zip: "admin zip", email: "admin1", password: "admin", role: 2)
admin2 = User.create!(name: "Admin Name1", address: "admin address", city: "admin city", state: "state", zip: "admin zip", email: "admin2", password: "admin", role: 2)
