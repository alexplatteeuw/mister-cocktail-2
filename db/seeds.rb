require 'open-uri'
require 'json'

10.times do 
  url = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
  names_serialied = open(url).read
  names = JSON.parse(names_serialied)
  name = names["drinks"].first["strDrink"]
  p Cocktail.create!(name: name)
end

url = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
drinks_serialized = open(url).read
drinks = JSON.parse(drinks_serialized)
first_ten_drinks = drinks["drinks"].first(10)

first_ten_drinks.first(10).each do |ingredient|
  p Ingredient.create!(name: ingredient["strIngredient1"])
end

(1..10).each do |n|
  p Dose.create!(cocktail_id: n, ingredient_id: n, description: "#{rand(10)}cl")
end
