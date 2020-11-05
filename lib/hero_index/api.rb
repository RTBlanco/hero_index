class HeroIndex::API
# returns an instance of a a hero
  @@Base = "https://superheroapi.com/api.php/2830450570610975/"
  def self.get_hero(hero)    
    url = hero.to_i > 0 ? (@@Base + hero) : (@@Base + "search/#{hero}")

    begin
      uri = URI.parse(url)
    rescue URI::InvalidURIError => e
      url = @@Base + "search/" + hero.gsub(/ /, "%20")
      uri = URI.parse(url)
    end

    response = Net::HTTP.get_response(uri)
    hero_info = JSON.parse(response.body)

    if hero_info.include?("results") # check if response used search or ID 
      unless hero_info["response"] == "error"
        HeroIndex::Hero.new(hero_info["results"][0])
      else
        false
      end
    else
      unless hero_info["response"] == "error"
        hero_info.shift
        HeroIndex::Hero.new(hero_info)
      else
        false
      end
    end
  end
end

