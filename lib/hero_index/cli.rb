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
        puts "looks with id"
        # Will call the api and look for the user 
        puts " " 

      when "name"
        puts "looking with name"
        puts " "
        puts "please enter the name:"
        name = gets.strip.downcase

        if hero = HeroIndex::API.get_hero(name)
          binding.pry
          puts "found #{hero.name}"
          hero_informaton(hero)
        else
          puts "user not found"
        end

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

end