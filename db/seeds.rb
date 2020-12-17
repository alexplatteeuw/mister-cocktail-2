require 'open-uri'
require 'json'

# Create cocktails

10.times do 
  url = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
  names_serialied = open(url).read
  names = JSON.parse(names_serialied)
  name = names["drinks"].first["strDrink"]
  p Cocktail.create!(name: name)
end

# Create ingredients

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
drinks_serialized = open(url).read
drinks = JSON.parse(drinks_serialized)
first_ten_drinks = drinks["drinks"].first(10)

first_ten_drinks.first(10).each do |ingredient|
  p Ingredient.create!(name: ingredient["strIngredient1"])
end

# Create doses

50.times do
  dose = Dose.new
  dose.description = "#{rand(1..10)}cl"
  c_id = rand(1..10)
  i_id = rand(1..10)
  dose.cocktail_id = c_id
  dose.ingredient_id = i_id
  dose.save! if Dose.where(cocktail_id: c_id, ingredient_id: i_id).empty?
  p dose
end

urls = [
        "https://res.cloudinary.com/alexplatteeuw/image/upload/v1608212839/tommy-van-kessel-8Zmm4NtXmdE-unsplash_uyvbrg.jpg", 
        "https://res.cloudinary.com/alexplatteeuw/image/upload/v1608212838/kyryll-ushakov-lwoTuByIuC4-unsplash_zdx5my.jpg", 
        "https://res.cloudinary.com/alexplatteeuw/image/upload/v1608212838/johann-trasch-gePb4Q1NL_U-unsplash_bs6i39.jpg", 
        "https://res.cloudinary.com/alexplatteeuw/image/upload/v1608212838/ralph-ravi-kayden-A557D1wZ3_k-unsplash_kikbic.jpg", 
        "https://res.cloudinary.com/alexplatteeuw/image/upload/v1608212838/logan-weaver-B9lUt97FL9I-unsplash_vfhhwl.jpg", 
        "https://res.cloudinary.com/alexplatteeuw/image/upload/v1608212838/kim-daniels-0eNtGDz8Ols-unsplash_nk5ahq.jpg", 
        "https://res.cloudinary.com/alexplatteeuw/image/upload/v1608205854/nu5f4h0ttm367md0svyvdnmsixz4.jpg", 
        "https://res.cloudinary.com/alexplatteeuw/image/upload/v1608053020/p1bjsoxueu7mscbhk99nhjhvt7zg.jpg", 
        "https://res.cloudinary.com/alexplatteeuw/image/upload/v1608053013/2b1jqxbz7k50r5ow4etvral1hbxg.jpg", 
        "https://res.cloudinary.com/alexplatteeuw/image/upload/v1608052995/l0gg9ludz3uhdkw4hpu6z62clylt.jpg"
        ]

Cocktail.all.each_with_index do |cocktail, index|
  cocktail.photo.attach(io: URI.open(urls[index]), filename: "#{index}-cocktail.jpg", content_type: 'image/jpg')
  p cocktail.photo.attached?
end
