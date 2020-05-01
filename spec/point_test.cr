require "gtk_custom_widgets/core/point"
require "spec"

describe GtkCustomWidgets::Point do
  context "test initialize" do
    it "when initialize without args " do
      p = GtkCustomWidgets::Point.new
      p.should be_a(GtkCustomWidgets::Point)
      p.x.should eq(0.0)
      p.y.should eq(0.0)
    end
    it "when initialize with float args " do
      p = GtkCustomWidgets::Point.new 1.0, 2.0
      p.should be_a(GtkCustomWidgets::Point)
      p.x.should eq(1.0)
      p.y.should eq(2.0)
    end
    it "when initialize with int args " do
      p = GtkCustomWidgets::Point.new 3, 4
      p.should be_a(GtkCustomWidgets::Point)
      p.x.should eq(3.0)
      p.y.should eq(4.0)
    end
    it "when initialize with 1 args " do
      p = GtkCustomWidgets::Point.new  y: 1.0
      p.should be_a(GtkCustomWidgets::Point)
      p.x.should eq(0.0)
      p.y.should eq(1.0)
      p1 = GtkCustomWidgets::Point.new  x: 10
      p1.should be_a(GtkCustomWidgets::Point)
      p1.x.should eq(10.0)
      p1.y.should eq(0.0)
    end
  end
end
