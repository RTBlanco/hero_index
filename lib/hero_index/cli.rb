class HeroIndex::CLI

  def call
    self.hero_lookup
  end

  def hero_lookup
    input = nil 
    while input != "exit"
      puts "Search Hero by name or hero ID"
      input = gets.strip.downcase

      case input

      when "id"
        look_id
      when "name"
        look_name
      else
        puts "wtf are you talking about ?"
        puts " "
      end
    end 
  end

  def hero_informaton(hero)
    puts "what would you like know about #{hero.name}"
    # here goes method commands 
    input = gets.strip.downcase
    puts input
  end

  def look_name
    puts "looking with name"
    puts " "
    puts "please enter the name:"
    
    name = gets.strip.downcase

    if hero = HeroIndex::API.get_hero(name)
      puts "found #{hero.name}"
      hero_informaton(hero)
    else
      puts "user not found"
    end
  end

  def look_id
    puts "looking with ID"
    puts " "
    puts "please enter ID"

    id = 0
    while id.to_i == 0
      puts "must be a numer"
      id = gets.strip
    end

    if hero = HeroIndex::API.get_hero(id)
      puts "found #{hero.name}"
      hero_informaton(hero)
    else
      puts "user not found"
    end
  end
   

end