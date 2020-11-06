class HeroIndex::CLI

  def run
    hero = hero_call
    hero_informaton(hero)
  end

  def hero_call
    # run = true 
    while true#run == true
      puts "Search Hero by name or hero ID".colorize(:yellow)
      input = gets.strip.downcase

      case input
      when "id"
        return look_id
        break# run = false
        # hero = look_name
        # hero_informaton(hero)
      when "name"
        return look_name
        break #run = false
        # hero = look_name
        # hero_informaton(hero)
      when "exit"
        exit!
      else
        puts "Sorry don't understand".colorize(:red)
        puts " "
      end
    end 
  end

  def hero_informaton(hero)
    puts "what would you like know about ".colorize(:yellow) + hero.name.colorize(:green)
    puts <<-DOC.colorize(:yellow)
      (1) main information 
      (2) physical traits
      (3) Power levels
      (4) Who is stonger (pits current hero verser another)
      -----------------------------------------------------
      (back) To go back 
      (quit) To quit program
      DOC
    running = true 
    while running == true
      input = gets.strip.downcase

      case input
      when "1"
        # main_info
      when "2"
        # physical
      when "3"
        show_pwr_lvls(hero)
      when "4"
        versus(hero)
      when "back"
        run
        running = false
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
      name = gets.strip

      if hero = HeroIndex::API.get_hero(name)
        puts " " 
        puts "found ".colorize(:yellow) + hero.name.colorize(:green)
        # hero_informaton(hero) # might use yeild
        return hero
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
    amount = 0 
    while id.to_i == 0 || id.to_i > 731
      puts amount == 0 ? "must be a numer".colorize(:yellow) : "must be a numer".colorize(:red)
      id = gets.strip
      amount += 1
    end

    if hero = HeroIndex::API.get_hero(id)
      puts " " 
      puts "found ".colorize(:yellow) + hero.name.colorize(:green)
       # hero_informaton(hero) # might use yeild
      return hero
    else
      puts "user not found".colorize(:red)
    end
  end

  def versus(hero)
    puts""
    puts "Pit hero against a".colorize(:yellow) +" new".colorize(:green) +" hero or the ".colorize(:yellow) + "last ".colorize(:green)+ "searched hero?".colorize(:yellow)
    # running = true 
    while true #running == true
      input = gets.strip.downcase 
      case input
      when "new"
        hero2 = hero_call
        break
      when "last"
        hero2 = HeroIndex::Hero.last_searched_hero
        break
      else
        puts "Enter ".colorize(:yellow) + '"name" '.colorize(:green) + "or ".colorize(:yellow) + ' "new"'.colorize(:green)
      end
    end
    
    puts hero.name.colorize(:green) + " vs " + hero2.name.colorize(:green)
    hero.is_stronger?(hero2) ? (puts hero.name.colorize(:green) + " is stronger".colorize(:yellow)) : (puts hero2.name.colorize(:green) + " is stronger".colorize(:yellow))
    puts ""
    hero_informaton(hero)
  end

  def show_pwr_lvls(hero)
    hero.powerstats.each do |k, v|
      puts "#{k}: " + v.to_s.colorize(:green)
    end
    puts <<-DOC.gsub /^\s+/, ""
      
      -----------------------------------------------------
    DOC
    # hero_informaton(hero)
    back_or_quit {hero_informaton(hero)}
  end    

  def back_or_quit
    puts <<-DOC.colorize(:yellow)
    -----------------------------------------------------
    (back) To go back 
    (quit) To quit program
    DOC
    
    input = gets.strip.downcase

    case input 
    when "back"
      yield
      # break # running = false
    when "quit"
      exit!
    else
      back_or_quit
    end
  end
end