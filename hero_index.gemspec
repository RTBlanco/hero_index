require_relative 'lib/hero_index/version'

Gem::Specification.new do |spec|
  spec.name          = "hero_index"
  spec.version       = HeroIndex::VERSION
  spec.authors       = ["RTBlanco"]
  spec.email         = ["ronnytoribio1@hotmail.com"]

  spec.summary       = %q{ This Ruby gem is a CLI that allows the user to be able to see information about their favorite heros.}
  spec.description   = %q{ This Ruby gem is a CLI that allows the user to be able to see information about their favorite heros.}
  spec.homepage      = "https://github.com/RTBlanco/hero_index"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/RTBlanco/hero_index"
  spec.metadata["changelog_uri"] = "https://github.com/RTBlanco/hero_index/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "colorize", "~> 0.8"
end
