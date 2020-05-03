require "cairo-gobject/cairo"

module GtkCustomWidgets

  class LineGeometry < Geometry

    property start_point : Point
    property end_point : Point

    def self.new : self
      new(Point.new, Point.new)
    end

    def initialize(start : Point, end_p : Point)
      @start_point = start
      @end_point = end_p
    end 

    def bounds : Cairo::Rectangle
      x = min(start_point.x, end_point.x)
      y = min(start_point.y, end_point.y)
      w = max(start_point.x, end_point.x) - min(start_point.x, end_point.x)
      h = max(start_point.y, end_point.y) - min(start_point.y, end_point.y)
    end

    def create_cairo_path(cr : Cairo::Context)
      cr.new_path.move_to(start_point.x, start_point.y).line_to(end_point.x, end_point.y)
    end

  end

end
