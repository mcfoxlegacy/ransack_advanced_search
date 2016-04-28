$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ransack_advanced_search/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ransack_advanced_search"
  s.version     = RansackAdvancedSearch::VERSION
  s.authors     = ["David Brusius"]
  s.email       = ["brusiusdavid@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of RansackAdvancedSearch."
  s.description = "Description of RansackAdvancedSearch."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', ['>= 3.2.6','< 5']
  s.add_dependency 'ransack', '~> 1.7.0', '>= 1.7.0'

  s.add_development_dependency 'pry', '~>0.10'
end
