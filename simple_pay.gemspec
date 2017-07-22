$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_pay/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_pay"
  s.version     = SimplePay::VERSION
  s.authors     = ["Buhtoyarov Artem 🙈"]
  s.email       = ["buhtoyarov1986@gmail.com"]
  s.homepage    = ""
  s.summary     = "SimplePay."
  s.description = "SimplePay."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2.18"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
end
