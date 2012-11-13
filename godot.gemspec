require File.expand_path("../lib/godot/version", __FILE__)

Gem::Specification.new do |s|
  s.name     = "godot"
  s.version  = Godot::VERSION
  s.platform = Gem::Platform::RUBY
  s.homepage = "https://github.com/ohrite/godot"
  s.authors  = ["Doc Ritezel", "Matthew Kocher"]
  s.email    = "ritezel+godot@pivotallabs.com"
  s.summary  = "The gem what makes waiting for stuff all easy-like."
  s.description   = "If you're going to be bored waiting for something, why not our good friend?"

  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-bundler"
  s.add_development_dependency "rb-fsevent"
  s.add_development_dependency "terminal-notifier"
  s.add_development_dependency "capybara"

  s.files         = `git ls-files`.split( "\n" )
  s.test_files    = `git ls-files -- spec/*`.split( "\n" )
  s.executables   = `git ls-files -- bin/*`.split( "\n" ).map{ |f| File.basename( f ) }
  s.require_path  = "lib"
  s.default_executable = "bin/godot"
end
