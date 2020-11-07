class HeroIndex::Hero 
  attr_accessor :id, :name
  attr_reader :powerstats, :appearance, :biography
  
  @@all = []
  def initialize(attri)
    attri.each do |key , value|
      if self.class.method_defined?(key.downcase)
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

  
  def appearance=(appearance)
    appearance.each do |k,v| 
      if v.kind_of?(Array)
        appearance.delete(k) if v[0].include?("-") || v[1].include?("-")
      elsif v == "-"
        appearance.delete(k)
      end
    end
    @appearance = appearance
    @appearance
  end
  
  def biography=(biography)
    @biography = biography.each {|k,v| biography.delete(k) if v == "-" || v == "No alter egos found."}
  end
  
  def gender_pronouns
    posibile_pronouns = [["His","He"],["Her","She"]]
    pronouns = self.appearance["gender"] == "Male" ? posibile_pronouns[0] : posibile_pronouns[1]
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

