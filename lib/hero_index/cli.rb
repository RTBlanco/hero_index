class HeroIndex::CLI

  @@line = "-" * 53
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
      when "quit"
        exit!
      else
        puts "Sorry don't understand".colorize(:red)
        puts " "
      end
    end 
  end

  def hero_informaton(hero)
    puts "what would you like know about ".colorize(:yellow) + hero.name.colorize(:green)
    puts "(".colorize(:yellow) + "1".colorize(:green) + ") main information
      (".colorize(:yellow) + "2".colorize(:green) +") physical traits
      (".colorize(:yellow) +"3".colorize(:green) + ") Power levels
      (".colorize(:yellow) + "4".colorize(:green) + ") Who is stonger (pits current hero verser another)
      #{@@line}
      (".colorize(:yellow) + "back".colorize(:green) + ") To go back
      (".colorize(:yellow) + "quit".colorize(:green) + ") To quit program".colorize(:yellow)
     
    while true
      input = gets.strip.downcase

      case input
      when "1"
        main_info(hero)
      when "2"
        physical_traits(hero)
      when "3"
        show_pwr_lvls(hero)
      when "4"
        versus(hero)
      when "back"
        run
        break # running = false
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
        puts "Enter ".colorize(:yellow) + '"last" '.colorize(:green) + "or ".colorize(:yellow) + ' "new"'.colorize(:green)
      end
    end
    
    puts hero.name.colorize(:green) + " vs ".colorize(:yellow) + hero2.name.colorize(:green)
    hero.is_stronger?(hero2) ? (puts hero.name.colorize(:green) + " is stronger".colorize(:yellow)) : (puts hero2.name.colorize(:green) + " is stronger".colorize(:yellow))
    puts ""
    hero_informaton(hero)
  end


  def show_pwr_lvls(hero)
    puts ""
    puts "#{hero.name}'s".colorize(:green) + " Powerlevels.".colorize(:yellow) 
    hero.powerstats.each do |k, v|
      puts "#{k}: " + v.to_s.colorize(:green)
    end
    puts @@line.colorize(:yellow)
    # hero_informaton(hero)
    back_or_quit {hero_informaton(hero)}
  end  

  
  def physical_traits(hero)
    puts ""
    puts "#{hero.name}'s".colorize(:green) + " physical traits.".colorize(:yellow)
    hero.appearance.each do |k , v|
      if v.kind_of?(Array)
        # binding.pry
        puts "#{k}: " + "#{v[0]}".colorize(:green) + " or " + "#{v[1]}.".colorize(:green)
      else
        puts "#{k}: " + "#{v}".colorize(:green)
      end
    end
    puts @@line.colorize(:yellow)
    back_or_quit {hero_informaton(hero)}
  end


  def main_info(hero)
    info = hero.biography 

    if hero.name != info["full-name"]
      puts "#{hero.name}'s ".colorize(:green) + "full name is " + "#{info["full-name"]}".colorize(:green) + "."
    end
    if info.include?("alter-egos")
      puts "their Alter ego is "+ "#{info["alter-egos"]}".colorize(:green)+ "."
    end
    if info.include?("place-of-birth")
      puts "They were born in " + "#{info["place-of-birth"]}".colorize(:green) + "."
    end

    puts "They were published by " + "#{info["publisher"]}".colorize(:green) + "."
    puts "They are mostly know as a "+ "#{info["alignment"]} ".colorize(:green) + "character."
    
    puts @@line.colorize(:yellow)
    back_or_quit {hero_informaton(hero)}
  end

  def back_or_quit
    while true
      puts "#{@@line}\n  (".colorize(:yellow)  + "back".colorize(:green) + ") To go back \n  (".colorize(:yellow) + "quit".colorize(:green) + ") To quit program".colorize(:yellow)
      input = gets.strip.downcase
      case input 
      when "back"
        yield
        break 
      when "quit"
        exit!
      end
    end
  end

end