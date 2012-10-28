shared_context "without a server", :target => false do
  let(:godot) { Godot.new("localhost", 1) }

  before do
    godot.stub(:timeout).and_return(0.1)
    godot.stub(:interval).and_return(0.01)
  end
end