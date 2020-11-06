class HeroIndex::Hero 
  attr_accessor :appearance, :biography, :id, :name
  attr_reader :powerstats
  
  @@all = []
  def initialize(attri)
    attri.each do |key , value|
      if self.class.method_defined?(key.downcase)          # unless key == "connections" || key == "image" || key == "work" 
        # binding.pry
        # self.class.attr_accessor(key)
        self.send("#{key.downcase}=", value)
      end
    end
    @@all << self
  end

  def is_stronger?(hero)
    self.powerstats > hero.powerstats
  end

  def powerstats=(powerstats)
    @powerstats = powerstats.each {|k,v| powerstats[k] = v.to_i }
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    self.all.find {|hero| hero.name == name}
  end

  def self.find_by_ID(id)
    self.all.find {|hero| hero.id == id}
  end

  def self.last_searched_hero
    self.all.count >=2 ? self.all[-2] : self.all[0]
  end

end

