require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(person_hash)
  film_names = []

  person_hash["films"].each do |film_url|
    film_names << get(film_url)
  end
  film_names
end



def find(character, url="http://www.swapi.co/api/people/")

  if person_finder(character, url)
    get_character_movies_from_api(person_finder(character))
  else
    page = page_turner(url)
    until page == nil
      if person_finder(character, page)
        return get_character_movies_from_api(person_finder(character, page))
      end
      page = page_turner(page)
    end
    puts "We could not find that character"
    []
  end
end

def get(url)
  all_info = RestClient.get(url)
  info_hash = JSON.parse(all_info)
end
=begin
RETURNS:
{"count"=>87,
 "next"=>"https://www.swapi.co/api/people/?page=2",
 "previous"=>nil,
 "results"=>
  [{"name"=>"Luke Skywalker",
    "height"=>"172",
    "mass"=>"77",
    "hair_color"=>"blond", ...}]
=end



def page_turner(url)
  get(url)["next"]
end
#RETURNS https://www.swapi.co/api/people/?page=2"

def person_finder(character, url="http://www.swapi.co/api/people/")
  page_hash = get(url)
  page_hash["results"].find {|person| person["name"].downcase == character.downcase}
end
=begin
{"name"=>"Darth Vader",
 "height"=>"202",
 "mass"=>"136",
 "hair_color"=>"none",
 "skin_color"=>"white",
 "eye_color"=>"yellow",
 "birth_year"=>"41.9BBY",
 "gender"=>"male",
 "homeworld"=>"https://www.swapi.co/api/planets/1/",
 "films"=>
  ["https://www.swapi.co/api/films/2/",
   "https://www.swapi.co/api/films/6/",
   "https://www.swapi.co/api/films/3/",
   "https://www.swapi.co/
=end



def parse_character_movies(films_hash)
  # film_hash ||= []
  # binding.pry
  films_hash.each do |film_hash|

    puts "#{film_hash["title"]}"
  end
end

def show_character_movies(character)
  films_hash = find(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

#pry.start
