class HeroIndex::Hero 
  
  @@all = []
  def initialize(attri)
    attri.each do |key , value|
      unless key == "connections" || key == "image" || key == "work" 
        self.class.attr_accessor(key)
        self.send(("#{key}="), value)
      end
    end
    @@all << self
  end

  

end