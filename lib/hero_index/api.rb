class HeroIndex::API
# returns an instance of a a hero
  @@Base = "https://superheroapi.com/api.php/2830450570610975/"
  def self.get_hero(hero)
    url = hero.to_i > 0 ? (@@Base + hero) : (@@Base + "search/#{hero}") #hero.is_a?(Integer
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    
    hero_info = JSON.parse(response.body)
    # binding.pry

    if hero_info.include?("results") # check if response used search or ID 
      unless hero_info["response"] == "error"
        return HeroIndex::Hero.new(hero_info["results"][0])
      else
        return false
      end
    else
      unless hero_info["response"] == "error"
        hero_info.shift
        return HeroIndex::Hero.new(hero_info)
      else
        return false
      end
    end
  end
 
end

