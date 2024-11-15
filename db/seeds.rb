# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "json"
url = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=3&api_key=b3e4ed8ed2bcc7f2900cf7ed578deba8"
movie_list = URI.open(url).read
movies = JSON.parse(movie_list)["results"]
puts "Creating movies"
movies.each do |movie|
  Movie.create(
    title: movie["original_title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/original#{movie["backdrop_path"]}",
    rating: movie["vote_average"].round(1))
end
puts "#{Movie.count} movies created!"
