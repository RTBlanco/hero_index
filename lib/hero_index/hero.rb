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
    @powerstats > hero.powerstats
  end

  def powerstats=(powerstats)
    binding.pry
    @powerstats = powerstats.each {|k,v| powerstats[k] = v.to_i }
  end

end

