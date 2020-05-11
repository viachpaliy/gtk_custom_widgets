require "gtk_custom_widgets/core/collection"
require "spec"

alias GtkCW = GtkCustomWidgets

describe GtkCW::Collection do
  context "test array methods" do
    it "when append value " do
      c = GtkCW::Collection(Int32).new
      c << 1
      c << 2
      c << 3
      c[0].should eq(1)
      c[1].should eq(2)
      c[2].should eq(3)
    end
    it "when replaces a subrange" do
      c = GtkCW::Collection(Int32).new
      c = [1,2,3,4,5]
      c[0].should eq(1)
      c[1].should eq(2)
      c[2].should eq(3)
      c.size.should eq(5)
    end

  end
end
