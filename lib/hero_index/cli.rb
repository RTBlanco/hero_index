class HeroIndex::CLI

  @@line = "-".colorize(:yellow) * 55
  def run
    hero = hero_call
    hero_menu(hero) {run}
  end

  def hero_call
    while true
      puts "Search Hero by ".colorize(:yellow) + "Name".colorize(:green) + " or hero ".colorize(:yellow) + "ID".colorize(:green) + "?".colorize(:yellow)
      input = gets.strip.downcase

      case input
      when "id"
        return look_id
        break        
      when "name"
        return look_name
        break
      when "quit"
        exit!
      else
        puts "Sorry don't understand\n".colorize(:red)
      end
    end 
  end


  def look_name
    puts "\nLooking with name!\nPlease enter the name.".colorize(:yellow)
    
    while true 
      name = gets.strip

      if name == "quit"
        !exit
      elsif name.downcase == "back"
        run 
      end
        


      if HeroIndex::Hero.find_hero_name(name).nil? 

        if self.class.valid_name(name) && hero = HeroIndex::API.get_hero(name)
          puts "\nFound ".colorize(:yellow) + hero.name.colorize(:green) + "!".colorize(:yellow)
          return hero
          break
        else
          puts "Hero not found, Try again!".colorize(:red)
        end
      else
        hero = HeroIndex::Hero.find_hero_name(name)
        puts "\nFound ".colorize(:yellow) + hero.name.colorize(:green) + "!".colorize(:yellow)
        return hero
        break
      end
    end
  end


  def look_id
    puts "\nLooking with ID!\nPlease enter ID.".colorize(:yellow)

    
    amount = 0 
    while true 
      puts amount == 0 ? "Must be a numer (1-732).".colorize(:yellow) : "Must be a numer (1-732)!".colorize(:red)
      id = gets.strip
      
      if id == "quit"
        !exit
      elsif id.downcase == "back"
        run 
      end
      
      amount += 1
      
      if HeroIndex::Hero.find_hero_id(id).nil? 
        if id != "0" && hero = HeroIndex::API.get_hero(id)
          puts "\nFound ".colorize(:yellow) + hero.name.colorize(:green)+ "!".colorize(:yellow)
          return hero
          break
        else
          puts "Hero not found!".colorize(:red)
        end
      else
        hero = HeroIndex::Hero.find_hero_id(id)
        puts "\nFound ".colorize(:yellow) + hero.name.colorize(:green)+ "!".colorize(:yellow)
        return hero
        break
      end
    end
  end


  def versus(hero)
    puts "\nPit hero against a".colorize(:yellow) +" New".colorize(:green) +" hero or the ".colorize(:yellow) + "Last ".colorize(:green)+ "searched hero?".colorize(:yellow)
     
    while true 
      input = gets.strip.downcase 
      case input
      when "new"
        hero2 = hero_call
        break
      when "last"
        hero2 = HeroIndex::Hero.last_searched_hero
        break
      when "quit"
        exit!
      else
        puts "Enter ".colorize(:yellow) + '"last" '.colorize(:green) + "or ".colorize(:yellow) + ' "new".'.colorize(:green)
      end
    end
    
    puts hero.name.colorize(:green) + " vs ".colorize(:yellow) + hero2.name.colorize(:green)
    hero.is_stronger?(hero2) ? (puts hero.name.colorize(:green) + " is stronger!\n".colorize(:yellow)) : (puts hero2.name.colorize(:green) + " is stronger!\n".colorize(:yellow))
    puts @@line.colorize(:yellow)
    hero_menu(hero) {run}
  end


  def show_pwr_lvls(hero)
    puts "\n#{hero.name}'s".colorize(:green) + " Powerlevels.".colorize(:yellow) 

    hero.powerstats.each do |k, v|
      puts "  #{k.capitalize}: " + v.to_s.colorize(:green)
    end
    puts @@line.colorize(:yellow)
    hero_menu(hero) {run}
  end  

  
  def physical_traits(hero)
    puts "\n#{hero.name}'s".colorize(:green) + " physical traits.".colorize(:yellow)

    hero.appearance.each do |k , v|
      if v.kind_of?(Array)
        puts "  #{k.capitalize.gsub(/-/," ")}: " + "#{v[0]}".colorize(:green) + " or " + "#{v[1]}.".colorize(:green)
      else
        puts "  #{k.capitalize.gsub(/-/," ")}: " + "#{v}".colorize(:green)
      end
    end
    puts @@line.colorize(:yellow)
    hero_menu(hero) {run}
  end


  def main_info(hero)
    puts "\n#{hero.name}'s".colorize(:green) + " main infomation.".colorize(:yellow)
    info = hero.biography 
    possessive, pronoun = hero.gender_pronouns
    
    puts "  #{hero.name}'s ".colorize(:green) + "ID is " + hero.id.colorize(:green)
    if hero.name != info["full-name"]
      puts "  #{possessive} " + "full name is " + "#{info["full-name"]}".colorize(:green) + "."
    end
    if info.include?("alter-egos")
      puts "  #{possessive} alter ego is "+ "#{info["alter-egos"]}".colorize(:green) + "."
    end
    if info.include?("place-of-birth")
      puts "  #{possessive} place of birth was in " + "#{info["place-of-birth"]}".colorize(:green) + "."
    end
    if info.include?("first-appearance")
      puts "  #{possessive} first appearance was in " + "#{info["first-appearance"]}".colorize(:green) + "."
    end
    
    puts "  #{pronoun} was published by " + "#{info["publisher"]}".colorize(:green) + "." + "\n  #{pronoun} is mostly know as a " + "#{info["alignment"]} ".colorize(:green) + "character.\n" + @@line.colorize(:yellow)
    hero_menu(hero) {run}
  end

  def hero_menu(hero)
    menu_txt = "What would you like to know about ".colorize(:yellow) + hero.name.colorize(:green) +"\n  (".colorize(:yellow) + "1".colorize(:green) + ") Main Information\n  (".colorize(:yellow) + "2".colorize(:green) +") Physical Traits\n  (".colorize(:yellow) +"3".colorize(:green) + ") Power Levels\n  (".colorize(:yellow) + "4".colorize(:green) + ") Who Is Stronger (pits current hero verser another)\n".colorize(:yellow)
    sub_menu_txt = "  (".colorize(:yellow) + "back".colorize(:green) + ") To go back\n  (".colorize(:yellow) + "quit".colorize(:green) + ") To quit program".colorize(:yellow)
     
    puts menu_txt
    puts "#{@@line}\n#{@@line}\n#{sub_menu_txt}\n"

    while true
      input = gets.strip.downcase
      
      case input  

      when "back"
        yield
        break 
      when "quit"
        exit!
      when "1"
        main_info(hero)
        break
      when "2"
        physical_traits(hero)
        break
      when "3"
        show_pwr_lvls(hero)
        break
      when "4"
        versus(hero)
        break
      else
        puts "Selection not available! Please select from the menu.\n".colorize(:red)
        hero_menu(hero) {run}
      end
    end
  end

  def self.valid_name(name)
    !(name =~ /{|}|\[|\]|'|"|\\|%|\^|\*|\(|\)|&|\$|#|@|!|_|\+|=/) && name.split("")[0] != "-"
  end

end