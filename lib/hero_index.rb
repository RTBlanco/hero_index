require "open-uri"
require 'net/http'
require "json"
require "awesome_print"
require "pry"

require_relative "hero_index/version"
require_relative "hero_index/cli"
require_relative "hero_index/hero"
require_relative "hero_index/api"



# module HeroIndex
#   class Error < StandardError; end
#   # Your code goes here...
# end

test = HeroIndex::API.get_hero("70")
test.powerstats
binding.pry