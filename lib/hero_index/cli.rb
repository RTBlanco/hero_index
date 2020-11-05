class HeroIndex::CLI

  def hero_call
    run = true 
    while run == true
      puts "Search Hero by name or hero ID".colorize(:yellow)
      input = gets.strip.downcase

      case input
      when "id"
        look_id
        run = false
      when "name"
        look_name
        run = false
      when "exit"
        run = false
      else
        puts "Sorry don't understand".colorize(:yellow)
        puts " "
      end
    end 
  end

  def hero_informaton(hero)
    puts "what would you like know about #{hero.name.colorize(:green)}".colorize(:yellow)
    puts <<-Doc
      (1) main information 
      (2) physical traits
      (3) Power levels
      (4) Who is stonger (pits current hero verser another)
      -----------------------------------------------------
      (back) To go back 
      (quit) To quit program
    Doc
    run = true 
    while run == true
      input = gets.strip.downcase

      case input
      when "1"
        # main_info
      when "2"
        # physical
      when "3"
        # list_powerstats
      when "4"
        # versus
      when "back"
        hero_call
        run = false
      when "quit"
        exit!
      else
        puts "Not a Valid option".colorize(:red)
      end
    end
  end



  def look_name
    puts "looking with name".colorize(:yellow)
    puts " "
    puts "please enter the name:".colorize(:yellow)
    
    # name = nil
    while true 
      name = gets.strip.downcase

      if hero = HeroIndex::API.get_hero(name)
        puts "found #{hero.name}"
        hero_informaton(hero)
        break
      else
        puts "user not found, Try again".colorize(:red)
      end
    end
  end

  def look_id
    puts "looking with ID".colorize(:yellow)
    puts " "
    puts "please enter ID".colorize(:yellow)

    id = nil
    while id.to_i == 0 || id.to_i > 731
      puts "must be a numer".colorize(:red)
      id = gets.strip
    end

    if hero = HeroIndex::API.get_hero(id)
      puts "found ".colorize(:yellow) + hero.name.colorize(:green)
      hero_informaton(hero)
    else
      puts "user not found".colorize(:red)
    end
  end

end