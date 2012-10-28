require "spec_helper"

describe Godot do
  describe "#wait!" do
    context "with a target", :target => true do
      it "is silent after successfully waiting" do
        expect { godot.wait! }.not_to raise_error
      end
    end

    context "without a target", :target => false do
      it "raises an exception when waiting goes awry" do
        expect { godot.wait! }.to raise_error
      end
    end
  end

  describe "#wait" do
    context "with a target", :target => true do
      it "returns true" do
        godot.wait.should be_true
      end
    end

    context "without a target", :target => false do
      it "returns false" do
        godot.wait.should be_false
      end
    end
  end

  describe "#match!" do
    context "with a target", :target => true do
      it "is silent" do
        expect { godot.match!(/This will match/) }.not_to raise_error
      end
    end

    context "without a target", :target => false do
      it "raises an exception" do
        expect { godot.match!(/Nope/) }.to raise_error
      end
    end
  end

  describe "#match" do
    context "without a target", :target => false do
      it "returns false" do
        godot.match(/Not in the least/).should be_false
      end
    end

    context "with a target", :target => true do
      it "returns true" do
        godot.match(/This will match/).should be_true
      end
    end
  end
end
