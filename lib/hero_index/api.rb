class HeroIndex::API
# returns an instance of a a hero
  @@Base = "https://superheroapi.com/api.php/2830450570610975/"
  def self.get_hero(hero)
    url = hero.is_a?(Integer) ? (@@Base + hero) : (@@Base + "search/#{hero}")
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    
    hero_info = JSON.parse(response.body)
    # binding.pry
    unless hero_info["response"] == "error"
      return HeroIndex::Hero.new(hero_info["results"][0])
    else
      return false
    end
  end
end

# HeroIndex::API.get_hero("???")