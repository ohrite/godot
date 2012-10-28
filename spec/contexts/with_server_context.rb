shared_context "with a server", :target => true do
  let(:app) { lambda { |env| [200, {}, ["This will match"]] } }
  let(:server) { Capybara::Server.new(app) }
  let(:godot) { Godot.new("localhost", server.port) }

  before { server.boot }
end