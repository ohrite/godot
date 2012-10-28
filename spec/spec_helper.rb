$:.push File.expand_path("../../lib", __FILE__)

require "godot"
require "capybara"

Dir.glob(File.expand_path("../contexts/**/*.rb", __FILE__)).each { |context| require context  }
